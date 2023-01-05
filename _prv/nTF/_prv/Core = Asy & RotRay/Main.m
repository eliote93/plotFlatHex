clc;
close all;
clear;
% ------------------------------------------------
%                  PLOT : Core & Rot Ray
% ------------------------------------------------
hold on;
axis equal;

Fn = "TST Rot Ray";

%aoF2F = 6.000869094655847;
%aoF2F = 4.61881388702243;
aoF2F = 20.6114;

nAsyCore = 4;

iSym = 60; % 1 : Sng Cel / 2 : Sng Asy
iAng = 1;  % Azm Ang Idx

PLOT_Core(aoF2F, nAsyCore, iSym);

PLOT_RotRayPts(Fn, aoF2F, nAsyCore, iSym, iAng, "ROT");

return