clc; close all; clear;
%% Problem = 3-D Core
nMC  = 1;
mStr = '3D C5G7 H FC UR 10M';
nStr = '3D C5G7 H FC UR DIV 08 060';
lErr = true; % ~lErr : Print Pm
lRel = true;

[Fm, Fn] = SET_FileName(mStr, nStr, nMC);
%% READ
[Pn, naRng, nAsy, npRng, nPin, naF2F, npF2F,  l60,  lROT] = READ_nTF(Fn);
[Pm, maRng, mAsy, mpRng, mPin, maF2F, mpF2F, pFac, sdMax] = READ_MC_REPEAT(nMC, Fm);

[Pn] = CHK_Inp(maRng, naRng, mpRng, npRng, maF2F, naF2F, mpF2F, npF2F, l60, nPin, Pn, lErr);
%% PLOT
[Pm_RAD, Pm_AX, mR, mZ] = INT_Pow(Pm, mPin);
[Pn_RAD, Pn_AX, nR, nZ] = INT_Pow(Pn, nPin);

[Pe_RAD, Pe_AX, RMS_RAD, MAX_RAD, RMS_AX, MAX_AX, nE] = SET_PowErr(Pm_RAD, Pm_AX, mR, mZ, Pn_RAD, Pn_AX, nR, nZ, maF2F, mpF2F, maRng, mpRng, l60, lROT, lErr, lRel);

PLOT_PowErr(Pe_RAD, nE, mpF2F, l60, lErr);

CONTROL_Plot(mStr, RMS_RAD, MAX_RAD, RMS_AX, MAX_AX, pFac, l60, lErr, lRel);

return