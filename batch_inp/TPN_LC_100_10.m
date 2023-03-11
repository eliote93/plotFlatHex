clc; close all; clear;
cd ../;
fn = 'TPN LC RX 100 10';
lrel = false; lplotxypln = false; lfnflag = false;
%% READ & INIT
[ndat, lerr, l3d, istr, igcf, fgca, xylmin, xylmax, zlmin, zlmax, lbrad, lbax] = READ_info(fn);
[grdrad, grdhgt] = READ_grid(fn, ndat, l3d);
[XX, YY, xymx] = SET_grid(ndat, grdrad);
%% PLOT : Rad.
[fid] = OPEN_file(fn, lerr, lrel, 'XY');
tline = fgetl(fid);
for iimag = 1:ndat(1, 2)
    PLOT_xy(fid, fn, ndat, l3d, lerr, lrel, istr, igcf, fgca, xylmin, xylmax, xymx, lbrad, XX, YY, lfnflag);
    
    if l3d && ~lplotxypln; break; end
end
fclose(fid);
%% PLOT : Ax.
if l3d
    [fid] = OPEN_file(fn, lerr, lrel, 'AX');
    tline = fgetl(fid);
    for iimg = 1:ndat(2, 2)
        PLOT_z(fid, fn, ndat, lerr, lrel, istr, igcf, fgca, zlmin, zlmax, lbax, grdhgt, lfnflag);
    end
    fclose(fid);
end
return