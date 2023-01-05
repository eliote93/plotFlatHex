clc;
close all;
clear;
% ------------------------------------------------
%                  PLOT : Core & Core Ray
% ------------------------------------------------
hold on;
axis equal;

%aoF2F = 6.000869094655847;
aoF2F = 4.61881388702243;
%aoF2F = 20.6114;

Fn = 'TST Core Ray Pts';
nAsyCore = 4;
iAng = 3;

%PLOT_Core_360(aoF2F, nAsyCore);
%PLOT_cRayPts_360(Fn, iAng);

PLOT_Core_060(aoF2F, nAsyCore);
%PLOT_cRayPts_060_VAC(Fn, iAng);
PLOT_cRayPts_060_REF(Fn, iAng, aoF2F, nAsyCore);

return