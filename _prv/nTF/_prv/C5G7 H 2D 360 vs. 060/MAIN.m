clc; close all; clear;
%% Problem = C5G7 H 2D Core 060
aPch = 11.9;
aF2F = 11.9 * sqrt(3.);
pF2F = 0.78 * sqrt(3.);

FnF = "C5G7_H_2D_360.out";
FnS = "C5G7_H_2D_060.out";
%% READ
[PnF, nAsyF, npRngF, nPinF] = READ_nTF(FnF); % Full-Core
[PnS, nAsyS, npRngS, nPinS] = READ_nTF(FnS); % Divided by Six

if npRngF ~= npRngS
    error('DIFFERENT DIMENSION');
end

[PnS] = MODIFY_aIdx360(nAsyS, nAsyF, nPinS, PnS);
%% PLOT
[Pe, RMS, MAX] = SET_PowErr(PnF, nPinF, PnS, nPinS);

PLOT_PowErr(PnS, Pe, nPinS, aF2F, nAsyF, pF2F, npRngS);

CONTROL_Plot(RMS, MAX);

return