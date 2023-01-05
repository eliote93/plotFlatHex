clc; close all; clear;
%% Problem = 3-D Sng Asy
nMC  = 1;
mStr = "VVER-1000 A02 FS20 3D V09 5M";
nStr = "VVER-1000 A02 FS20 3D V09";

[Fm, Fn] = SET_FileName(mStr, nStr, nMC);
%% READ
[Pm, mpRng, mPin, sdMax] = READ_MC_REPEAT(nMC, Fm);
[Pn, npRng, nPin, pF2F]  = READ_nTF(Fn);

if mpRng ~= npRng || mPin ~= nPin
    error('DIFFERENT DIMENSION');
end

fprintf('Peacking Factor : %8.5f \n', max(Pm(1, :)));
fprintf('Maximum Std. Dev. : %8.5f (percent) \n', sdMax);
%% PLOT
[Pm_RAD, Pm_AX, mR, mZ] = INT_Pow(Pm, mPin);
[Pn_RAD, Pn_AX, nR, nZ] = INT_Pow(Pn, nPin);

[Pe_RAD, Pe_AX, RMS_RAD, MAX_RAD, RMS_AX, MAX_AX] = SET_PowErr(Pm_RAD, Pm_AX, mR, mZ, Pn_RAD, Pn_AX, nR, nZ);

PLOT_PowErr(Pe_RAD, nR, pF2F, npRng);

CONTROL_Plot(9., -10., RMS_RAD, MAX_RAD, RMS_AX, MAX_AX);

return