function CONTROL_Plot(RMS, MAX)

str1 = sprintf('MAX: %.2f%%',MAX);
str2 = sprintf('RMS: %.2f%%',RMS);
text(35,-40,{str1,str2}, 'FontWeight', 'bold', 'FontSize', 20);

xlabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
ylabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
set(gca, 'FontSize', 30, 'FontWeight', 'bold')

%xlim([-aF2F*0.5 aF2F*0.5]);
%ylim([-aPch aPch]);

c = colorbar;
c.Label.String = '\bf Relative Pin Power Error (%)';
set(c, 'FontSize', 30);
caxis([0. 2.]);

axis equal
FUNC_polarmap

end

