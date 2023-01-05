clc;close all;clear;

fid1 = 'RENUS_NEACRP_C1_QC.out'; % RENUS
fid2 = 'MASTER_NEACRP_C1_FC';    % MASTER
lRel = true;
lErr = true;

[F2F_R, nY_R, nX_R, nZ_R, nA_R, Pr1d_R, Pax_R, PPM_R] = READ_RENUS(fid1);
[F2F_M, nY_M, nX_M, nZ_M, nA_M, Pr1d_M, Pax_M, PPM_M] = READ_MASTER(fid2);

[F2F, nAY, nAX, nZ, nA] = CHK_Inp(F2F_R, nY_R, nX_R, nZ_R, nA_R, F2F_M, nY_M, nX_M, nZ_M);
[xyA] = SET_xyA(nAY, nAX, nA);

[Prd_E, Pax_E, Max_Rd, Max_Ax, RMS_Rd, RMS_Ax, Pf] = SET_PowErr(nA, nZ, Pr1d_R, Pax_R, Pr1d_M, Pax_M, lRel, lErr);

PLOT_PowErr(F2F, nA, xyA, Prd_E);

CONTROL_Plot(Max_Rd, RMS_Rd, Max_Ax, RMS_Ax, F2F, nAY, Pf, lRel, lErr, PPM_R - PPM_M);