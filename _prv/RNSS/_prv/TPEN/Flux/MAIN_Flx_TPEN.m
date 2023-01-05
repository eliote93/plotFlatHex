clc; close all; clear;
%% PLOT = TPEN Flx
ig   = 2;
ndiv = 5;
ipa  = 1;
Fr   = "RENUS BOILER_CORE_3D_FC.out";

[aF2F, npa, Poly] = READ_ARTOS(Fr);

hold on;
axis equal;

for ind = 1:6
    PLOT_Flx_Tri(aF2F, Poly, ipa, ind, ig, ndiv);
end

xlabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
ylabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
set(gca, 'FontSize', 30, 'FontWeight', 'bold')

c = colorbar;
c.Label.String = '\bf Normalized Flux';
set(c, 'FontSize', 30);