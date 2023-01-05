SUBROUTINE plotpow()
! PLOT : inputted Power instead Power Error

USE mdat,  ONLY : lerr, plotmod, delpow, nz, NTpow, MCpow, axpf

IMPLICIT NONE
! ------------------------------------------------

IF (lerr) RETURN

SELECT CASE (plotmod)
CASE ('NT'); delpow(1:nz) = NTpow(1:nz)
CASE ('MC'); delpow(1:nz) = MCpow(1:nz)
END SELECT

axpf = maxval(delpow(1:nz))

WRITE (*, '(A27, F7.2)') 'Ax. Power Peaking Factor : ', axpf
! ------------------------------------------------

END SUBROUTINE plotpow