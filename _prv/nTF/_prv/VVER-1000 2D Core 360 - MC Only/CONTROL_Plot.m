function CONTROL_Plot(aF2F)

% ------------------------------------------------
%                  A04 V03 360
% ------------------------------------------------
xlabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
ylabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
set(gca, 'FontSize', 30, 'FontWeight', 'bold')

c = colorbar;
c.Label.String = '\bf Normalized Power';
set(c, 'FontSize', 30);
caxis([0. 2.]);

axis equal
FUNC_polarmap

Bndy = [-aF2F*8 aF2F*8];

xlim(Bndy);
ylim(Bndy);

end