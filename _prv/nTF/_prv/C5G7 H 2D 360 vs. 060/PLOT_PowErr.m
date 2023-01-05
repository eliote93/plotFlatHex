function PLOT_PowErr(Pn, Pe, nPin, aF2F, nAsy, pF2F, npRng)

[aCnt] = SET_AsyCnt(aF2F, nAsy);

pPch   = pF2F / sqrt(3.);
[pCnt] = SET_PinCnt(pF2F, npRng);

x = [-0.5 0.5 1  0.5 -0.5  -1];
y = [ 0.5 0.5 0 -0.5 -0.5   0];

x = x * pPch;
y = y * pF2F;

nP = 0;
XX = [];
YY = [];
ZZ = [];
CC = [];
Z  = ones(1,6);

for iPin = 1:nPin
    if Pn(4, iPin) < 1E-7
        continue
    end
    
    ix   = Pe(1, iPin);
    iy   = Pe(2, iPin);
    iAsy = Pe(3, iPin);
    
    X = x + pCnt(1, ix, iy) + aCnt(1, iAsy);
    Y = y + pCnt(2, ix, iy) + aCnt(2, iAsy);
    
    XX = [XX;X];
    YY = [YY;Y];
    ZZ = [ZZ;Z];
    CC = [CC;ones(1,6) * Pe(4, iPin)];
    
    nP = nP + 1;
end

if nP ~= 0
    patch(XX',YY',CC',CC','LineStyle','None');
end

end
