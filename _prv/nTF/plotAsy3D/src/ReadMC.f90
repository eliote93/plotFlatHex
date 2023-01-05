! --------------------------------------------------------------------------------------------------
SUBROUTINE readMC_one()

USE allocs
USE param, ONLY : ONE
USE mdat,  ONLY : nMC, rMC, MCndat, MCdat, tmppow, numthr, lerr, lrel, plotmod

IMPLICIT NONE

INTEGER :: iMC, idat
! ------------------------------------------------

IF (.NOT.lerr .AND. plotmod.NE.'MC' .AND. .NOT.lrel) RETURN

rMC = ONE / real(nMC)

! 1st
CALL readMC_1st

CALL dmalloc(tmppow, MCndat)

! 2nd
DO iMC = 2, nMC
  CALL readMC_2nd(iMC)
  
  !$OMP PARALLEL PRIVATE(idat) NUM_THREADS(numthr)
  !$OMP DO SCHEDULE(GUIDED)
  DO idat = 1, MCndat
    MCdat(idat) = MCdat(idat) + tmppow(idat)
  END DO
  !$OMP END DO
  !$OMP END PARALLEL
END DO

DEALLOCATE (tmppow)

CALL calMCstd
! ------------------------------------------------

END SUBROUTINE readMC_one
! --------------------------------------------------------------------------------------------------
SUBROUTINE readMC_1st()

USE allocs
USE param, ONLY : DOT, BANG, BLANK, TRUE, oneline, probe
USE mdat,  ONLY : MCfn, MCndat, rMC, numthr, indev, nz, hgt, MCdat, MCstd, MCz, avghgt

IMPLICIT NONE

CHARACTER*10  :: cn
CHARACTER*100 :: fn, cdum

INTEGER :: iz, idat, nchr, MCnz
INTEGER :: ipos(6)
REAL :: tmp, totpow, rnrm
! ------------------------------------------------

fn = 'MC\' // trim(MCfn) // ' 01'

CALL openfile(indev, TRUE, fn)
! ------------------------------------------------
!            01. # of data
! ------------------------------------------------
MCndat = 0

DO
  READ (indev, '(A512)', END = 1000) oneline
  
  IF (probe .EQ. DOT)   EXIT
  IF (probe .EQ. BANG)  CYCLE
  IF (probe .EQ. BLANK) CYCLE
  
  READ (oneline, *) cn
  CALL toupper(cn)
  
  IF (cn .NE. '*CELL') CYCLE
    
  MCndat = MCndat + 1
END DO

1000 CONTINUE

REWIND (indev)

CALL dmalloc(MCdat, MCndat)
CALL dmalloc(MCstd, MCndat)
CALL dmalloc(MCz,   MCndat)
! ------------------------------------------------
!            02. READ
! ------------------------------------------------
MCndat = 0
MCnz   = 0

DO
  READ (indev, '(A512)', END = 2000) oneline
  
  IF (probe .EQ. DOT)   EXIT
  IF (probe .EQ. BANG)  CYCLE
  IF (probe .EQ. BLANK) CYCLE
  
  READ (oneline, *) cn
  CALL toupper(cn)
  
  IF (cn .NE. '*CELL') CYCLE
  
  ! READ
  MCndat = MCndat + 1
  
  READ (oneline, *) cn, cdum, cdum
  
  CALL fndchr(cdum, ipos, nchr, '_')
  
  READ (cdum(ipos(3)+1:ipos(4)-1), *) MCz(MCndat)
  
  ! Pow. + Std. Dev.
  CALL fndchr(oneline, ipos, nchr, '=')
  
  oneline = oneline(ipos(1)+1:)
  
  READ (oneline, *) MCdat(MCndat), cdum, cdum, cdum, tmp
  
  ! CnP
  MCstd(MCndat) = tmp * rMC * 100._8
  
  MCnz = max(MCnz, MCz(MCndat))
END DO

2000 CONTINUE

CLOSE (indev)

IF (nz .NE. MCnz) CALL terminate("MC HGT.")
! ------------------------------------------------
!            04. Norm.
! ------------------------------------------------
totpow = ZERO

DO idat = 1, MCndat
  iz = MCz(idat)
  
  totpow = totpow + MCdat(idat) * hgt(iz) / avghgt
END DO

rnrm = rMC * real(MCndat) / totpow

!$OMP PARALLEL PRIVATE(idat) NUM_THREADS(numthr)
!$OMP DO SCHEDULE(GUIDED)
DO idat = 1, MCndat
  MCdat(idat) = MCdat(idat) * rnrm ! McCARD Power is Point-wise
END DO
!$OMP END DO
!$OMP END PARALLEL
! ------------------------------------------------

END SUBROUTINE readMC_1st
! --------------------------------------------------------------------------------------------------
SUBROUTINE readMC_2nd(iMC)

USE param, ONLY : BLANK, ZERO, DOT, BANG, TRUE, oneline, probe
USE mdat,  ONLY : MCfn, tmppow, rMC, indev, hgt, numthr, MCstd, avghgt, MCndat, MCz

IMPLICIT NONE

CHARACTER*10  :: cn
CHARACTER*100 :: fn, cdum

INTEGER :: iMC, nchr, ndat, idat, iz
INTEGER :: ipos(6)
REAL :: totpow, rnrm, tmp
! ------------------------------------------------

IF (iMC .LT. 10) THEN
  WRITE (cn, '(I1)') iMC
  
  fn = 'MC\' // trim(MCfn) // " 0"  // trim(cn)
ELSE
  WRITE (cn, '(I2)') iMC
  
  fn = 'MC\' // trim(MCfn) // BLANK // trim(cn)
END IF

CALL openfile(indev, TRUE, fn)
! ------------------------------------------------
ndat = 0

DO
  READ (indev, '(A512)', END = 3000) oneline
  
  IF (probe .EQ. DOT)   EXIT
  IF (probe .EQ. BANG)  CYCLE
  IF (probe .EQ. BLANK) CYCLE
  
  READ (oneline, *) cn
  CALL toupper(cn)
  
  IF (cn .NE. '*CELL') CYCLE
    
  ! READ
  ndat = ndat + 1
  
  CALL fndchr(oneline, ipos, nchr, '=')
  
  oneline = oneline(ipos(1)+1:)
  
  READ (oneline, *) tmppow(ndat), cdum, cdum, cdum, tmp
  
  MCstd(ndat) = MCstd(ndat) + tmp * rMC * 100._8
END DO

3000 CONTINUE

CLOSE (indev)

IF (ndat .NE. MCndat) CALL terminate("MC 2nd")
! ------------------------------------------------
totpow = ZERO

DO idat = 1, MCndat
  iz = MCz(idat)
  
  totpow = totpow + tmppow(idat) * hgt(iz) / avghgt
END DO

rnrm = rMC * real(MCndat) / totpow

!$OMP PARALLEL PRIVATE(idat) NUM_THREADS(numthr)
!$OMP DO SCHEDULE(GUIDED)
DO idat = 1, MCndat
  tmppow(idat) = tmppow(idat) * rnrm
END DO
!$OMP END DO
!$OMP END PARALLEL
! ------------------------------------------------

END SUBROUTINE readMC_2nd
! --------------------------------------------------------------------------------------------------
SUBROUTINE calMCstd()

USE param, ONLY : ZERO
USE mdat,  ONLY : MCstd, MCdat, MCz, MCndat, hgt, avghgt

IMPLICIT NONE

INTEGER :: iz, idat
REAL :: maxstdrel, rmsstdrel, maxstdabs, rmsstdabs, tmpabs
! ------------------------------------------------

maxstdrel = ZERO
rmsstdrel = ZERO
maxstdabs = ZERO
rmsstdabs = ZERO

DO idat = 1, MCndat
  iz = MCz(idat)
  
  maxstdrel = max(maxstdrel, MCstd(idat))
  rmsstdrel = rmsstdrel + MCstd(idat) * MCstd(idat) * hgt(iz) / avghgt
  
  tmpabs = MCstd(idat) * MCdat(idat)
  
  maxstdabs = max(maxstdabs, tmpabs)
  rmsstdabs = rmsstdabs + tmpabs * tmpabs * hgt(iz) / avghgt
END DO

rmsstdrel = rmsstdrel / real(MCndat)
rmsstdabs = rmsstdabs / real(MCndat)

WRITE (*, '(A31, F5.2, X, A3)') 'MC Power Std. Dev. Max. Rel. : ', maxstdrel, '(%)'
WRITE (*, '(A31, F5.2, X, A3)') 'MC Power Std. Dev. RMS  Rel. : ', rmsstdrel, '(%)'
WRITE (*, '(A31, F5.2, X, A3)') 'MC Power Std. Dev. Max. Abs. : ', maxstdabs, '(%)'
WRITE (*, '(A31, F5.2, X, A3)') 'MC Power Std. Dev. RMS  Abs. : ', rmsstdabs, '(%)'
! ------------------------------------------------

END SUBROUTINE calMCstd
! --------------------------------------------------------------------------------------------------