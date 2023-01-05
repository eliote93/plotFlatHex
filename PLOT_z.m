function PLOT_z(fid, fn, ndat, lerr, lrel, istr, igcf, fgca, zlmin, zlmax, lbax, grdhgt)
%% READ : Info.
nz = ndat(2, 1);

if nz == 0
    return;
end

xstr  = istr(2, 1);
ystr  = istr(2, 2);
nsize = istr(2, 3);
%% READ
tline = fgetl(fid);
Intro = textscan(tline, '%s', 1000);
cn    = sscanf(Intro{1}{1}, '%s');

if (lerr)
    errmax = sscanf(Intro{1}{2}, '%f');
    errrms = sscanf(Intro{1}{3}, '%f');
    ist    = 1;
else
    powpf = sscanf(Intro{1}{2}, '%f');
    ist   = 2;
end

err = zeros(1, nz+1);

for iz = 1:nz
    err(iz) = sscanf(Intro{1}{ist + iz}, '%f');
end

err(nz+1) = err(nz);

if ~lerr && lrel
    tline = fgetl(fid);
    Intro = textscan(tline, '%s', 1000);
    dn    = sscanf(Intro{1}{1}, '%s');

    ref = zeros(1, nz);
    
    for iz = 1:nz
        ref(iz) = sscanf(Intro{1}{1 + iz}, '%f');
    end
    
    ref(nz+1) = ref(nz);
end
%% PLOT
f2 = figure;
figure(f2);
hold on;

if ~lerr && lrel
    stairs(grdhgt(1:nz+1), err(1:nz+1), 'linewidth', 5);
    stairs(grdhgt(1:nz+1), ref(1:nz+1), 'linewidth', 5);
    legend(cn, dn);
elseif ~ lerr
    stairs(grdhgt(1:nz+1), err(1:nz+1), 'linewidth', 5);
else
    stairs(grdhgt(1:nz+1), err(1:nz+1), 'linewidth', 5);
    plot([0, grdhgt(nz+1)], [0. 0.], '-.r', 'linewidth', 1);
end
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
xlabel('Height (cm)', 'FontSize', nsize, 'fontweight', 'b');
set(gca, 'fontsize', nsize, 'fontweight', 'b')
ylabel(lbax, 'FontSize', nsize, 'fontweight', 'b');

caxis([zlmin zlmax]);

xlim([0  grdhgt(nz+1)]);
if lerr
    ylim([-ylimax ylimax]);
else
    ylim([0 ylimax]);
end

set(gcf, 'Position', igcf(2, 1:4))
set(gca, 'Position', fgca(2, 1:4))
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

%gn = strcat(fn, "_z_", en, cn, ".png");
gn = strcat(fn, "_z_", en, ".png");
saveas(f2, gn);
close(f2);
end