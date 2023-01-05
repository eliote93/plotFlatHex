Fn = "Ax_Data";

[Pz, Lz, Sd, nD, nZ, sX, sY] = READ_Data(Fn);

nF = 30;
nL = 3;

PLOT_Data(Pz, Lz, Sd, nD, nZ, sX, sY, nF, nL);