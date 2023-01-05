MODULE mdat

IMPLICIT NONE

CHARACTER*2   :: plotmod
CHARACTER*100 :: fdir, NTfn, MCfn

LOGICAL :: lerr, lrel, lNT
! ------------------------------------------------
INTEGER :: nMC, xstr1d, nsize1d, numthr, indev, gcf1d(4)
INTEGER :: nz, MCnxy, MCndat

INTEGER, POINTER, DIMENSION(:) :: MCz ! (idat)
! ------------------------------------------------
REAL :: rMC, ystr1d, avghgt, axpf, axrms, axmax, zlim, gca1d(4)

REAL, POINTER, DIMENSION(:) :: MCdat  ! (idat)
REAL, POINTER, DIMENSION(:) :: tmppow ! (idat)
REAL, POINTER, DIMENSION(:) :: MCstd  ! (idat)
REAL, POINTER, DIMENSION(:) :: NTpow  ! (iz)
REAL, POINTER, DIMENSION(:) :: MCpow  ! (iz)
REAL, POINTER, DIMENSION(:) :: hgt    ! (iz)
REAL, POINTER, DIMENSION(:) :: delpow ! (iz)
! ------------------------------------------------

END MODULE mdat