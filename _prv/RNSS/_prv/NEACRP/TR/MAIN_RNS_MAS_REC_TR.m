clc;close all;clear;

Fr   = 'RENUS_NEACRP_C2_QC.plt';  % RENUS
Fm   = 'MASTER_NEACRP_C2_HC.sum'; % MASTER
lMas = false;

[nTot_R, Tot_R, Max_R, Fin_R] = READ_RENUS(Fr);
[nTot_M, Tot_M, Max_M, Fin_M] = READ_MASTER(Fm, lMas);

CHK_Inp(nTot_R, Tot_R, nTot_M, Tot_M, lMas);

[Tot_E, Max_E, Fin_E] = SET_Err(nTot_R, Tot_R, Max_R, Fin_R, Tot_M, Max_M, Fin_M, lMas);

PLOT_MasErr(nTot_R, Tot_R, Tot_M, Tot_E, Max_E, Fin_E, lMas);

PLOT_RefErr(Max_R, Fin_R, Fr);