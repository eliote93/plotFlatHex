clc;
close all;
clear;
% ------------------------------------------------
%                  PLOT : Cel Msh & mRay
% ------------------------------------------------
%aiF2F = 5.800869094655847;
%aoF2F = 6.000869094655847;
%nPin = 4;

%aiF2F = 4.21881388702243;
%aoF2F = 4.61881388702243;
%nPin = 3;

pF2F  = 1.35099962990372;
pPch  = pF2F / sqrt(3.);
%aoPch = aoF2F / sqrt(3.);

hold on;
axis equal;

nRng = 2;
sRng = [0.3818376618407357 0.54];

%PLOT_RodCelMsh(pF2F, nRng, sRng);
%PLOT_GapCelMsh(pF2F, nPin, aiF2F, aoF2F);
PLOT_SngCelMsh(pF2F, nRng, sRng);

xlim([-1.1 * pF2F * 0.5, 1.1 * pF2F * 0.5]);
ylim([-1.1 * pPch,       1.1 * pPch]);

RayEqn = [0.05921541222457754, -1, -0.155];
PLOT_Line(RayEqn, 2, 'r')

SegPts(1,1) = -0.675499815;
SegPts(2,1) = 0.115;
SegPts(1,2) = -0.525599308;
SegPts(2,2) = 0.12387642;
SegPts(1,3) = -0.35761891;
SegPts(2,3) = 0.133823449;
SegPts(1,4) = -0.243494119;
SegPts(2,4) = 0.140581395;
SegPts(1,5) = -8.65E-02;
SegPts(2,5) = 0.149876033;
SegPts(1,6) = 0.00E+00;
SegPts(2,6) = 0.155;
SegPts(1,7) = 9.27E-02;
SegPts(2,7) = 0.160486726;
SegPts(1,8) = 0.299149918;
SegPts(2,8) = 0.172714286;
SegPts(1,9) = 0.339326274;
SegPts(2,9) = 0.175093345;
SegPts(1,10) = 0.507306673;
SegPts(2,10) = 0.185040374;
SegPts(1,11) = 0.675499815;
SegPts(2,11) = 0.195;

PLOT_Pts(SegPts, 11)

return