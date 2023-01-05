SUBROUTINE chkinp()

USE allocs
USE param, ONLY : EPS
USE mdat,  ONLY : lerr, lNT, plotmod, delpow, nz, MCdat, MCpow, MCz, MCndat, zlim

IMPLICIT NONE

INTEGER :: idat, iz, MCnxy
! ------------------------------------------------

! CHK : LOGICAL
lNT = lerr .OR. plotmod.EQ.'NT'

IF (.NOT.lerr .AND. plotmod.NE.'NT' .AND. plotmod.NE.'MC') CALL terminate("PLOT MODE")

CALL dmalloc(delpow, nz)

IF (.NOT.lerr .AND. plotmod.EQ.'NT') RETURN

IF (abs(zlim) .LT. EPS) CALL terminate("AXIAL ERROR LEGEND")

! SET : MC Ax. Power
IF (mod(MCndat, nz) .NE. 0) CALL terminate("MC ndat")

MCnxy = MCndat / nz

CALL dmalloc(MCpow, nz)

DO idat = 1, MCndat
  iz = MCz(idat)
  
  MCpow(iz) = MCpow(iz) + MCdat(idat)
END DO

MCpow = MCpow / real(MCnxy)
! ------------------------------------------------

END SUBROUTINE chkinp