clc; close all; clear;

Fa  = 'RENUS BOILER_CORE_3D_FC.out';
ipa = 1;

[nPin, pF2F, Pa] = READ_ARTOS(Fa);

PLOT_PinPower(nPin, pF2F, ipa, Pa);
CONTROL_Plot();

return