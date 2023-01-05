clc; close all; clear;
% ------------------------------------------------
%                  A04 V03 360
% ------------------------------------------------
aF2F = 23.6;
pF2F = 1.275;
nMC  = 1;

Fm = ["A04 V03 20M 01"];
%% READ
for iMC = 1:nMC
    [tPm(:, :, iMC), mAsy, mpRng, mPin, sdMax(iMC)] = READ_MC(Fm(iMC));
end

Pm = zeros(6, mPin);

for iPin = 1:mPin
    Pm(2:7, iPin) = tPm(2:7, iPin, 1);
    Pm(1, iPin) = sum(tPm(1, iPin, 1:nMC)) / nMC;
end

fprintf('Peacking Factor : %8.5f \n', max(Pm(1, :)));
fprintf('Maximum Std. Dev. : %8.5f \n', 100 * max(sdMax(1:nMC)));
%% PLOT
PLOT_PowErr(Pm, mPin, aF2F, pF2F, mpRng);

CONTROL_Plot(aF2F);

return