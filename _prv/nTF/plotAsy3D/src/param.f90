MODULE param

IMPLICIT NONE

CHARACTER*1, PARAMETER :: DOT   = '.'
CHARACTER*1, PARAMETER :: BLANK = ' '
CHARACTER*1, PARAMETER :: ASTR  = '*'
CHARACTER*1, PARAMETER :: BANG  = '!'
CHARACTER*1, PARAMETER :: SLASH = '/'

LOGICAL, PARAMETER :: TRUE  = .TRUE.
LOGICAL, PARAMETER :: FALSE = .FALSE.

REAL, PARAMETER :: ZERO = 0._8
REAL, PARAMETER :: ONE  = 1._8
REAL, PARAMETER :: HALF = 0.5_8
REAL, PARAMETER :: EPS  = 1E-7
REAL, PARAMETER :: SQ3  = 1.73205080756888_8
REAL, PARAMETER :: PI   = 3.14159265358979_8

CHARACTER*1 :: probe
CHARACTER*512 :: oneline

EQUIVALENCE (probe, oneline)

END MODULE param