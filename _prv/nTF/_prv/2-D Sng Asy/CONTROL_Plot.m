function CONTROL_Plot(mStr, RMS, MAX, lRel, lErr)

% C5G7 H    (6.3, -9,
% VVER-1000 (7.5, -11.,
% ABR       (5.,  -8,

if strcmp(mStr(4:9), 'C5G7 H ')
    xStr = 6.3;
    yStr = -9.;
elseif strcmp(mStr(1:8), 'VVER-440')
    xStr = 4.7;
    yStr = -7.;
elseif strcmp(mStr(1:9), 'VVER-1000')
    xStr = 7.5;
    yStr = -11.
end

str1 = sprintf('MAX : %.2f%%',MAX);
str2 = sprintf('RMS : %.2f%%',RMS);

if lErr
    text(xStr, yStr,{str1,str2}, 'FontWeight', 'bold', 'FontSize', 30);
end

xlabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
ylabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
set(gca, 'FontSize', 30, 'FontWeight', 'bold')

%xlim([-aF2F*0.5 aF2F*0.5]);
%ylim([-aPch aPch]);

c = colorbar;
if ~lErr
    c.Label.String = '\bf Normalized Pin Power';
elseif lRel
    c.Label.String = '\bf Relative Pin Power Error (%)';
else
    c.Label.String = '\bf Absolute Pin Power Error (%)';
end
set(c, 'FontSize', 30);

if ~lErr
    caxis([0, 2]);
else
    caxis([-2, 2]);
end


axis equal
FUNC_polarmap(lErr);

end