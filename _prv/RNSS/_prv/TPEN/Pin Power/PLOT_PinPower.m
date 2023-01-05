function PLOT_PinPower(nPin, pF2F, ipa, Pa)

nRng   = 2*nPin - 1;
pPch   = pF2F / sqrt(3.);
[pCnt] = SET_PinCnt(pF2F, nRng);

x = [-0.5 0.5 1  0.5 -0.5  -1] * pPch;
y = [ 0.5 0.5 0 -0.5 -0.5   0] * pF2F;

XX = [];
YY = [];
CC = [];

ixb = 1;
ixe = nPin;

for iy = 1:nRng
    for ix = ixb:ixe
        X = x + pCnt(1, ix, iy);
        Y = y + pCnt(2, ix, iy);
        
        XX = [XX;X];
        YY = [YY;Y];
        CC = [CC;ones(1,6) * Pa(ix, iy, ipa)];
    end
    
    if iy < nPin
        ixe = ixe + 1;
    else
        ixb = ixb + 1;
    end
end

if nPin ~= 0
    patch(XX',YY',CC',CC','LineStyle','None');
end

end
