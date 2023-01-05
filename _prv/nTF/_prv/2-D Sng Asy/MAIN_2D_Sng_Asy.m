clc; close all; clear;
%% Problem = 2-D Sng Asy
nMC  = 1;
mStr = 'VVER-440 Full-Core SA 03 5M';
nStr = 'VVER-440 Full-Core SA 03';
lRel = true;
lErr = false;

[Fm, Fn] = SET_FileName(mStr, nStr, nMC);
%% READ
[Pm, mpRng, mPin]        = READ_MC_REPEAT(nMC, Fm);
[Pn, npRng, nPin, pF2F]  = READ_nTF(Fn);

if mpRng ~= npRng || mPin ~= nPin
    error('DIFFERENT DIMENSION');
end
%% PLOT
[Pe, RMS, MAX] = SET_PowErr(Pm, Pn, nPin, mPin, lRel, lErr);

PLOT_PowErr(Pe, nPin, pF2F, npRng);
CONTROL_Plot(mStr, RMS, MAX, lRel, lErr);

return