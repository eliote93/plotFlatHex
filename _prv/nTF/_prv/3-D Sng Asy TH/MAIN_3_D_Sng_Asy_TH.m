clc; close all; clear;
%% Problem = 3-D TH
Fn = "nTF VVER-1000 A02 FS20 3D TH V09.out";

[T1, T2, T3, T4, nF, nP, nZ] = READ_nTF(Fn);

[Z1, Z2, Z3, Z4] = INT_Rad(T1, T2, T3, T4, nF, nP, nZ);

return