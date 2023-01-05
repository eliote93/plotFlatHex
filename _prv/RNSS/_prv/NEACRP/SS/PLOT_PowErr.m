function PLOT_PowErr(F2F, nA, xyA, Prd_E)

XX = [];
YY = [];
ZZ = [];
CC = [];

X(1) =   F2F * 0.5;
X(2) =   F2F * 0.5;
X(3) = - F2F * 0.5;
X(4) = - F2F * 0.5;

Y(1) =   F2F * 0.5;
Y(2) = - F2F * 0.5;
Y(3) = - F2F * 0.5;
Y(4) =   F2F * 0.5;

Z = ones(4);

for ia = 1:nA
    Cnt(1) = xyA(1, ia) * F2F;
    Cnt(2) = xyA(2, ia) * F2F;
    
    x(1:4) = Cnt(1) + X(1:4);
    y(1:4) = Cnt(2) + Y(1:4);
    
    XX = [XX;x];
    YY = [YY;y];
    ZZ = [ZZ;Z];
    CC = [CC;ones(1,4) * Prd_E(1, ia)];
end

patch(XX',YY',CC',CC','LineStyle','None');

end