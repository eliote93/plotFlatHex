PROGRAM plotAsy3D
! ASSUME : Only One Fuel Pin Type

USE mdat, ONLY : fdir, numthr

IMPLICIT NONE

fdir   = 'C:\Users\user\Documents\MATLAB\'
numthr = 6

CALL readinp
CALL readnTF
CALL readMC_one
CALL chkinp
CALL plotpow
CALL calpowerr
CALL editout

END PROGRAM plotAsy3D