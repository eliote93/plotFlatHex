function PLOT_PowErr(F2F, nAY, nA, xyA, Prd_E)

Pch = F2F / sqrt(3.);
kY  = (nAY + 1) / 2;

XX = [];
YY = [];
ZZ = [];
CC = [];

X(1) = - F2F * 0.5;
X(2) = - F2F * 0.5;
X(3) = 0.;
X(4) =   F2F * 0.5;
X(5) =   F2F * 0.5;
X(6) = 0.;

Y(1) =   Pch * 0.5;
Y(2) = - Pch * 0.5;
Y(3) = - Pch;
Y(4) = - Pch * 0.5;
Y(5) =   Pch * 0.5;
Y(6) =   Pch;

Z = ones(6);

for ia = 1:nA
    Cnt(1) = (xyA(1, ia) - kY) * F2F + 0.5 * (kY - xyA(2, ia)) * F2F;
    Cnt(2) = (kY - xyA(2, ia)) * Pch * 1.5;
    
    x(1:6) = Cnt(1) + X(1:6);
    y(1:6) = Cnt(2) + Y(1:6);
    
    XX = [XX;x];
    YY = [YY;y];
    ZZ = [ZZ;Z];
    CC = [CC;ones(1,6) * Prd_E(ia)];
end

patch(XX',YY',CC',CC','LineStyle','None');

end