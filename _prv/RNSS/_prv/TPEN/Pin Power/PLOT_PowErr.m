function PLOT_PowErr(Pe, nPin, pF2F, nRng)

pPch   = pF2F / sqrt(3.);
[pCnt] = SET_PinCnt(pF2F, nRng);

x = [-0.5 0.5 1  0.5 -0.5  -1] * pPch;
y = [ 0.5 0.5 0 -0.5 -0.5   0] * pF2F;

XX = [];
YY = [];
CC = [];

for iPin = 1:nPin
    ipx = Pe(6, iPin);
    ipy = Pe(7, iPin);
    
    X = x + pCnt(1, ipx, ipy);
    Y = y + pCnt(2, ipx, ipy);
    
    XX = [XX;X];
    YY = [YY;Y];
    CC = [CC;ones(1,6) * Pe(1, iPin)];
end

if nPin ~= 0
    patch(XX',YY',CC',CC','LineStyle','None');
end

end
