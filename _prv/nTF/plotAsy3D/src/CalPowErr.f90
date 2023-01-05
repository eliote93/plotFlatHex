SUBROUTINE calpowerr()

USE param, ONLY : ZERO
USE mdat,  ONLY : lerr, lrel, delpow, NTpow, MCpow, axrms, axmax, hgt, avghgt, nz

IMPLICIT NONE

INTEGER :: iz
REAL :: NTtot, MCtot, tmp
! ------------------------------------------------

IF (.NOT. lerr) RETURN

! DEBUG
NTtot = sum(NTpow(1:nz))
MCtot = sum(MCpow(1:nz))

!MCpow = MCpow * NTtot / MCtot

! CAL : Err.
tmp = ZERO

DO iz = 1, nz
  IF (lrel) THEN
    delpow(iz) = 100. * (NTpow(iz) - MCpow(iz)) / MCpow(iz)
  ELSE
    delpow(iz) = 100. * (NTpow(iz) - MCpow(iz))
  END IF
  
  tmp = tmp + delpow(iz) * delpow(iz) * hgt(iz) / avghgt
END DO

axmax = max(maxval(delpow(1:nz)), abs(minval(delpow(1:nz))))
axrms = sqrt(tmp / nz)
! ------------------------------------------------

END SUBROUTINE calpowerr