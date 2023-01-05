function CONTROL_Plot(xStr, yStr, RMS_RAD, MAX_RAD, RMS_AX, MAX_AX)

str1 = sprintf('RAD MAX: %.2f%%', MAX_RAD);
str2 = sprintf('RAD RMS: %.2f%%', RMS_RAD);
str3 = sprintf('AX MAX: %.2f%%', MAX_AX);
str4 = sprintf('AX RMS: %.2f%%', RMS_AX);
text(xStr, yStr,{str1, str2, str3, str4}, 'FontWeight', 'bold', 'FontSize', 20);

xlabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
ylabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
set(gca, 'FontSize', 30, 'FontWeight', 'bold')

%xlim([-aF2F*0.5 aF2F*0.5]);
%ylim([-aPch aPch]);

c = colorbar;
c.Label.String = '\bf Relative Pin Power Error (%)';
set(c, 'FontSize', 30);
caxis([-2, 2]);

axis equal
FUNC_polarmap(lErr);

end