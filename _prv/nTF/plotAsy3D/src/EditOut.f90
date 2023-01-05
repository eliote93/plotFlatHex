SUBROUTINE editout()

USE param, ONLY : FALSE, DOT
USE mdat,  ONLY : indev, NTfn, MCfn, xstr1d, ystr1d, nsize1d, lerr, lrel, gcf1d, gca1d, nz, lNT, axpf, axmax, axrms, hgt, delpow, NTpow, MCpow, zlim

IMPLICIT NONE

CHARACTER*100 :: fnout, fnorg

INTEGER :: iz, nxy
! ------------------------------------------------

IF (lNT) THEN
  fnorg = trim(NTfn)
ELSE
  fnorg = trim(MCfn)
END IF

WRITE (fnout, '(A, A4)') trim(fnorg), '.inp'

CALL openfile(indev, FALSE, fnout)

! 2-D (Null)
WRITE (indev, '(I5, 3L2)')      0, lerr, lrel, FALSE
WRITE (indev, '(3ES13.5)')      axpf, axmax, axrms
WRITE (indev, '(I5, F7.2, I5)') xstr1d, ystr1d, nsize1d
WRITE (indev, '(4I6)')          gcf1D(1:4)
WRITE (indev, '(4F6.3)')        gca1D(1:4)

! 1-D
WRITE (indev, '(I5, 3L2)')      nz, lerr, lrel, FALSE
WRITE (indev, '(4ES13.5)')      axpf, axmax, axrms, zlim
WRITE (indev, '(I5, F7.2, I5)') xstr1d, ystr1d, nsize1d
WRITE (indev, '(4I6)')          gcf1D(1:4)
WRITE (indev, '(4F6.3)')        gca1D(1:4)

IF (.NOT.lerr .AND. lrel) THEN
  DO iz = 1, nz
    WRITE (indev, '(100ES13.5)') hgt(iz), NTpow(iz), MCpow(iz)
  END DO
ELSE
  DO iz = 1, nz
    WRITE (indev, '(100ES13.5)') hgt(iz), delpow(iz)
  END DO
END IF

WRITE (indev, '(A1)') DOT

CLOSE (indev)
! ------------------------------------------------

END SUBROUTINE editout