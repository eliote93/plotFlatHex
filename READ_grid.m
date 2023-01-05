function [grdrad, grdhgt] = READ_grid(fn, ndat, l3d)
% ASSUME : Fixed Format

%% Default
nxy    = ndat(1,1);
nz     = ndat(2,1);
ncard  = 4;
grdrad = zeros(nxy, 12);
grdhgt = zeros(1, nz+1);
%% READ : Rad.
gn  = strcat(fn, '.grid');
fid = fopen(gn);
if fid < 0
    error('WRONG FILE NAME')
end

for ii = 1:3
    tline = fgetl(fid);
end

for ixy = 1:nxy
    tline = fgetl(fid);
    nLgh  = length(tline);
    Intro = textscan(tline(ncard+1:nLgh), '%s', 100);
    
    for ii = 1:12
        grdrad(ixy, ii) = sscanf(Intro{1}{ii}, '%f');
    end
end
%% READ : Ax.
if l3d == true
    for ii = 1:3
        tline = fgetl(fid);
    end
    
    for iz = 1:nz
        tline = fgetl(fid);
        nLgh  = length(tline);
        Intro = textscan(tline(ncard+1:nLgh), '%s', 100);
        
        grdhgt(iz+1) = grdhgt(iz) + sscanf(Intro{1}{1}, '%f');
    end
end

fclose(fid);
end