clc;close all;clear;

fid1 = 'RENUS_BOILER_CORE_ARO.out'; % RENUS
fid2 = 'MASTER_BOILER_CORE_ARO';    % MASTER
lRel = true;
lErr = true;
iPow = 1; % 1 : RENUS, 2 : MASTER

[F2F_R, nAY_R, nAX_R, nZ_R, nA_R, Prd_R, Pax_R] = READ_RENUS(fid1);
[F2F_M, nAY_M, nAX_M, nZ_M, nA_M, Prd_M, Pax_M] = READ_MASTER(fid2);

[F2F, nAY, nAX, nZ, nA] = CHK_Inp(F2F_R, nAY_R, nAX_R, nZ_R, nA_R, F2F_M, nAY_M, nAX_M, nZ_M);
[Prd_E, Pax_E, Max_Rd, RMS_Rd, Max_Ax, RMS_Ax, Pf] = SET_PowErr(nZ, nA, Prd_R, Pax_R, Prd_M, Pax_M, lRel, lErr, iPow);
[xyA] = SET_AsyMap(nAY, nAX, nA);

PLOT_PowErr(F2F, nAY, nA, xyA, Prd_E);
CONTROL_Plot(Max_Rd, RMS_Rd, Max_Ax, RMS_Ax, Pf, lRel, lErr)

return