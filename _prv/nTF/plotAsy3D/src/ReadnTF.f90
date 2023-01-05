SUBROUTINE readnTF()

USE allocs
USE param, ONLY : TRUE, EPS, ZERO, oneline
USE mdat,  ONLY : lerr, lrel, plotmod, NTfn, indev, NTpow, nz, hgt, avghgt

IMPLICIT NONE

CHARACTER*100 :: fn

LOGICAL :: chknum
INTEGER :: iz, NTnz, tmp1
REAL :: tmp2, totpow, rnrm
! ------------------------------------------------

IF (.NOT.lerr .AND. plotmod.NE.'NT' .AND. .NOT.lrel) RETURN

fn = 'nTF\' // trim(NTfn) // '.out'

CALL openfile(indev, TRUE, fn)
! ------------------------------------------------
!            01. READ : # of Ax.
! ------------------------------------------------
CALL moveline(indev, "- Radially Averaged 1D Power -")
CALL skipline(indev, 1)

NTnz = 0

DO
  READ (indev, '(A512)') oneline
  
  IF (.NOT. chknum(oneline)) EXIT
  
  READ (oneline, *) tmp1, tmp2
  
  IF (tmp2 .LT. EPS) CYCLE
  
  NTnz = NTnz + 1
END DO

REWIND (indev)

IF (NTnz .NE. nz) CALL terminate("NT nz")

CALL dmalloc(NTpow, nz)
! ------------------------------------------------
!            02. READ : Ax. Pow.
! ------------------------------------------------
CALL moveline(indev, "- Radially Averaged 1D Power -")
CALL skipline(indev, 1)

NTnz = 0

DO
  READ (indev, '(A512)') oneline
  
  IF (.NOT. chknum(oneline)) EXIT
  
  READ (oneline, *) tmp1, tmp2
  
  IF (tmp2 .LT. EPS) CYCLE
  
  NTnz = NTnz + 1
  
  NTpow(NTnz) = tmp2
END DO

CLOSE (indev)
! ------------------------------------------------
!            03. Norm.
! ------------------------------------------------
totpow = ZERO

DO iz = 1, nz
  totpow = totpow + NTpow(iz) * hgt(iz) / avghgt
END DO

rnrm = real(nz) / totpow

DO iz = 1, nz
  NTpow(iz) = NTpow(iz) * rnrm
END DO
! ------------------------------------------------

END SUBROUTINE readnTF