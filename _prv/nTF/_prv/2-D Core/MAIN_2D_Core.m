clc; close all; clear;
%% Problem = 2-D Core
nMC  = 5;
mStr = 'V-10 SC 2D A02 V01 5M';
nStr = 'V-10 SC 2D HS A02 V01 GM TRC';
lErr = true; % ~lErr : Print Pm
lRel = true;

[Fm, Fn] = SET_FileName(mStr, nStr, nMC);
%% READ
[Pn, naRng, npRng, nPin, naF2F, npF2F,  lHS, lROT] = READ_nTF(Fn);
[Pm, maRng, mpRng, mPin, maF2F, mpF2F, pFac]       = READ_MC_REPEAT(nMC, Fm);

[Pn] = CHK_Inp(maRng, naRng, mpRng, npRng, maF2F, naF2F, mpF2F, npF2F, lHS, nPin, Pn, lErr);
%% PLOT
[Pe, nE, RMS, MAX] = SET_PowErr(Pm, mPin, Pn, nPin, maF2F, mpF2F, maRng, mpRng, lHS, lROT, lErr, lRel);

PLOT_PowErr(Pe, nE, mpF2F, lHS, lErr);

CONTROL_Plot(mStr, RMS, MAX, pFac, lHS, lErr, lRel);

return