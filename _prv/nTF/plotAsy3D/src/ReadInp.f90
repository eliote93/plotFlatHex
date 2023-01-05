SUBROUTINE readinp

USE allocs
USE param, ONLY : DOT, BANG, BLANK, TRUE, ZERO, oneline, probe
USE mdat,  ONLY : NTfn, MCfn, nMC, lerr, plotmod, lrel, xstr1d, ystr1d, nsize1d, indev, gcf1d, gca1d, nz, hgt, avghgt, zlim

IMPLICIT NONE

CHARACTER*13 :: fn, cn, tmp2

INTEGER :: lgh1, lgh2, fndndata, ndat, idat
LOGICAL :: lext

CHARACTER*30, DIMENSION(100) :: tmp1
! ------------------------------------------------

fn    = 'plotAsy3D.inp'
indev = 42
nz    = 1
zlim  = ZERO

INQUIRE (FILE = fn, EXIST = lext)

IF (.NOT.lext) CALL terminate("FILE DOES NOT EXIST - " // fn)

OPEN (indev, FILE = fn)

DO
  READ (indev, '(A512)', END = 1000) oneline
  
  IF (probe .EQ. DOT)   EXIT
  IF (probe .EQ. BANG)  CYCLE
  IF (probe .EQ. BLANK) CYCLE
  
  READ (oneline, '(A13)') cn
  CALL toupper(cn)
  
  lgh1 = len(cn)
  lgh2 = len(oneline)
  
  SELECT CASE (cn)
  CASE ('ID_NTF')
    NTfn = oneline(lgh1+1:lgh2)
    
    CALL rmvremainder(NTfn)
    
  CASE ('ID_MC')
    MCfn = oneline(lgh1+1:lgh2)
    
    CALL rmvremainder(MCfn)
    
  CASE ('NUM_MC')
    READ (oneline, *) cn, nMC
    
  CASE ('PLOT_ERR')
    READ (oneline, *) cn, lerr
    
    IF (.NOT. lerr) READ (oneline, *) cn, lerr, plotmod
    
  CASE ('CAL_REL')
    READ (oneline, *) cn, lrel
    
  CASE ('TPOS_1D')
    READ (oneline, *) cn, xstr1d, ystr1d
      
  CASE ('TSIZE_1D')
    READ (oneline, *) cn, nsize1D
    
  CASE ('GCF_1D')
    READ (oneline, *) cn, gcf1d(1:4)
    
  CASE ('GCA_1D')
    READ (oneline, *) cn, gca1d(1:4)
    
  CASE ('HGT')
    ndat = fndndata(oneline)-1
    tmp1 = BLANK
    
    READ (oneline, *, END = 500) cn, tmp1
    
    500 CONTINUE
    
    DO idat = 1, 100
      READ (tmp1(idat), '(A)') tmp2
      
      IF (tmp2(1:1).EQ.BLANK .OR. tmp2(1:1).EQ.BANG) EXIT
    END DO
    
    nz = idat-1
    
    CALL dmalloc(hgt, nz)
    
    READ (oneline, *) cn, hgt(1:nz)
    
  CASE ('ZLIM')
    READ (oneline, *) cn, zlim
    
  CASE DEFAULT
    CALL terminate("READ INP")
  END SELECT
END DO

1000 CONTINUE

CLOSE (indev)

IF (.NOT. associated(hgt)) CALL dmalloc1(hgt, 1)

avghgt = sum(hgt(1:nz)) / nz
! ------------------------------------------------

END SUBROUTINE readinp