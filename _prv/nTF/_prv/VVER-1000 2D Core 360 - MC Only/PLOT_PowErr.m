function PLOT_PowErr(Pe, nPin, aF2F, pF2F, npRng)

[aCnt] = SET_AsyCnt(aF2F, Pe);
[pCnt] = SET_PinCnt(pF2F, npRng);

pPch = pF2F / sqrt(3.);

x = [-0.5 0.5 1  0.5 -0.5  -1] * pPch;
y = [ 0.5 0.5 0 -0.5 -0.5   0] * pF2F;

XX = [];
YY = [];
CC = [];

for iPin = 1:nPin
    iax = Pe(3, iPin);
    iay = Pe(4, iPin);
    ipx = Pe(6, iPin);
    ipy = Pe(7, iPin);
    
    X = x + pCnt(1, ipx, ipy) + aCnt(1, iax, iay);
    Y = y + pCnt(2, ipx, ipy) + aCnt(2, iax, iay);
    
    XX = [XX;X];
    YY = [YY;Y];
    CC = [CC;ones(1,6) * Pe(1, iPin)];
end

if nPin ~= 0
    patch(XX',YY',CC',CC','LineStyle','None');
end

end