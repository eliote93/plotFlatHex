function [ndat, lerr, l3d, istr, igcf, fgca, xylmin, xylmax, zlmin, zlmax, lbrad, lbax] = READ_info(fn)
% ASSUME : Fixed Format

%% Default
ncard  = 9;
xylmin = 0.;
xylmax = 1.;
zlmin  = 0.;
zlmax  = 1.;
lbax   = '';
ndat   = zeros(2,2);
%% SKIP : Echo
gn  = strcat(fn, '.info');
fid = fopen(gn);
if fid < 0
    error('WRONG FILE NAME')
end

while 1
    tline = fgetl(fid);
    nLgh  = length(tline);
    
    if (nLgh < 6)
        continue;
    elseif (tline(1:6) == "$ Rad.")
        break;
    end
end
%% READ : Rad.
while 1
    tline = fgetl(fid);
    nLgh  = length(tline);
    
    if (nLgh < 1)
        continue;
    elseif (tline(1:1) == '.')
        fclose(fid);
        return;
    elseif (tline(1:5) == "$ Ax.")
        break;
    end
    
    Intro = textscan(tline(ncard+1:nLgh), '%s', 100);
    
    switch tline(1:ncard)
        case "# of Dat."
            ndat(1, 1) = sscanf(Intro{1}{1}, '%d');
            ndat(1, 2) = sscanf(Intro{1}{2}, '%d');
        case "  LOGICAL"
            lerr = sscanf(Intro{1}{1}, '%c') == 'T';
            l3d = sscanf(Intro{1}{2}, '%c') == 'T';
        case "   String"
            istr(1, 1) = sscanf(Intro{1}{1}, '%f');
            istr(1, 2) = sscanf(Intro{1}{2}, '%f');
            istr(1, 3) = sscanf(Intro{1}{3}, '%f');
        case "      GCF"
            igcf(1, 1) = sscanf(Intro{1}{1}, '%d');
            igcf(1, 2) = sscanf(Intro{1}{2}, '%d');
            igcf(1, 3) = sscanf(Intro{1}{3}, '%d');
            igcf(1, 4) = sscanf(Intro{1}{4}, '%d');
        case "      GCA"
            fgca(1, 1) = sscanf(Intro{1}{1}, '%f');
            fgca(1, 2) = sscanf(Intro{1}{2}, '%f');
            fgca(1, 3) = sscanf(Intro{1}{3}, '%f');
            fgca(1, 4) = sscanf(Intro{1}{4}, '%f');
         case "   Legend"
             xylmin = sscanf(Intro{1}{1}, '%f');
             xylmax = sscanf(Intro{1}{2}, '%f');
         case "    Label"
             lbrad = tline(ncard+1:nLgh);
    end
end
%% READ : Ax.
while 1
    tline = fgetl(fid);
    nLgh   = length(tline);
    
    if (nLgh < 1)
        continue;
    elseif (tline(1:1) == '.')
        fclose(fid);
        return;
    end
    
    Intro = textscan(tline(ncard+1:nLgh), '%s', 100);
    
    switch tline(1:ncard)
        case "# of Dat."
            ndat(2, 1) = sscanf(Intro{1}{1}, '%d');
            ndat(2, 2) = sscanf(Intro{1}{2}, '%d');
        case "   String"
            istr(2, 1) = sscanf(Intro{1}{1}, '%f');
            istr(2, 2) = sscanf(Intro{1}{2}, '%f');
            istr(2, 3) = sscanf(Intro{1}{3}, '%f');
        case "      GCF"
            igcf(2, 1) = sscanf(Intro{1}{1}, '%d');
            igcf(2, 2) = sscanf(Intro{1}{2}, '%d');
            igcf(2, 3) = sscanf(Intro{1}{3}, '%d');
            igcf(2, 4) = sscanf(Intro{1}{4}, '%d');
        case "      GCA"
            fgca(2, 1) = sscanf(Intro{1}{1}, '%f');
            fgca(2, 2) = sscanf(Intro{1}{2}, '%f');
            fgca(2, 3) = sscanf(Intro{1}{3}, '%f');
            fgca(2, 4) = sscanf(Intro{1}{4}, '%f');
        case "   Legend"
            zlmin = sscanf(Intro{1}{1}, '%f');
            zlmax = sscanf(Intro{1}{2}, '%f');
        case "    Label"
            lbax = tline(ncard+1:nLgh);
    end
end
end