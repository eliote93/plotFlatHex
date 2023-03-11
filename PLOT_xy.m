function PLOT_xy(fid, fn, ndat, l3d, lerr, lrel, istr, igcf, fgca, xylmin, xylmax, xymx, lbrad, XX, YY, lfnflag)
%% READ : Info.
nxy = ndat(1, 1);

if nxy == 0
    return;
end

xstr  = istr(1, 1);
ystr  = istr(1, 2);
nsize = istr(1, 3);
%% READ
tline = fgetl(fid);
Intro = textscan(tline, '%s', 1000);
cn    = sscanf(Intro{1}{1}, '%s');

if lerr
    errmax = sscanf(Intro{1}{2}, '%f');
    errrms = sscanf(Intro{1}{3}, '%f');
else
    powpf  = sscanf(Intro{1}{2}, '%f');
end

iquo  = 0;
NLGH  = 100; % PARAM.
CC    = [];

while(1)
    iquo  = iquo + 1;
    istxy = NLGH*(iquo-1) + 1;
    iedxy = min(NLGH*iquo, nxy);
    
    if istxy > nxy
        break;
    end
    
    tline = fgetl(fid);
    Intro = textscan(tline, '%s', 1000);
    
    for ixy = 1:iedxy-istxy+1
        powerr = sscanf(Intro{1}{ixy}, '%f');
        CC = [CC;ones(1, 6) * powerr];
    end
end
%% PLOT
f1 = figure;
figure(f1);

patch(XX',YY',CC','LineStyle','None');
%% CNTL : Text
if lerr
    str1 = sprintf('MAX : %.2f%%', errmax); % Strictly, Not % in Abs. Err.
    str2 = sprintf('RMS : %.2f%%', errrms);
    
    text(xstr, ystr, {str1, str2}, 'FontWeight', 'bold', 'FontSize', nsize);
else
    str = sprintf('P.F. : %.2f%', powpf);
    %iimg = sscanf(cn, '%d'); str = sprintf('%6.2f s', 0.25*iimg); % DEBUG
    text(xstr, ystr, str, 'FontWeight', 'bold', 'FontSize', nsize);
end
%% CNTL : Layout
c = colorbar;
set(c, 'FontSize', 30);
xlabel('Distance from Center (cm)', 'FontSize', 30, 'FontWeight', 'bold')
ylabel('Distance from Center (cm)', 'FontSize', 30, 'FontWeight', 'bold')
set(gca, 'FontSize', 30, 'FontWeight', 'bold')
c.Label.String = lbrad;

caxis([xylmin xylmax]);

xlim([xymx(1, 1) xymx(1, 2)]);
ylim([xymx(2, 1) xymx(2, 2)]);

axis equal
set(gcf, 'Position', igcf(1, 1:4))
set(gca, 'Position', fgca(1, 1:4))

if lerr
    FUNC_polarmap(true);
else
    colormap('jet');
end
%% SAVE : PNG
if lerr
    if lrel
        en = "rel";
    else
        en = "abs";
    end
else
    en = "pow";
end

if lfnflag
    if l3d
        gn = strcat(fn, "_xy_", en, "_", cn, ".png");
    else
        gn = strcat(fn, "_xy_", en, ".png");
    end
else
    gn = strcat(fn, ".png");
end

cd out\;
saveas(f1, gn);
close(f1);
cd ..\;
end