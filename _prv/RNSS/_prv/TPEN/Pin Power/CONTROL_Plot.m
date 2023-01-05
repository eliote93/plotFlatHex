function CONTROL_Plot()

% C5G7 H    (6.3, -9,
% VVER-1000 (7.5, -11.,
% ABR       (5.,  -8,

xlabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
ylabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
set(gca, 'FontSize', 30, 'FontWeight', 'bold')

%xlim([-aF2F*0.5 aF2F*0.5]);
%ylim([-aPch aPch]);

c = colorbar;
c.Label.String = '\bf Normalized Pin Power';
set(c, 'FontSize', 30);

caxis([0, 1]);

axis equal

end