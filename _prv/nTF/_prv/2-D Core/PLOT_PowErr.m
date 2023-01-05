function PLOT_PowErr(Pe, nE, pF2F, lHS, lErr)

if ~lErr
    lHS = false;
end

pPch = pF2F / sqrt(3.);
rEps = 1E-5;

x0 = [-0.5 0.5 1  0.5 -0.5  -1] * pPch;
y0 = [ 0.5 0.5 0 -0.5 -0.5   0] * pF2F;

xNN = [-1. -0.5  0.5 1. 1. 1.] * pPch;
yNN = [ 0. -0.5 -0.5 0. 0. 0.] * pF2F;

xSW = [-0.5  0.5 1 0.5 0.5 0.5] * pPch;
ySW = [ 0.5 -0.5 0 0.5 0.5 0.5] * pF2F;

if ~lHS
    xNN = x0; xSW = x0;
    yNN = y0; ySW = y0;
end

XX = [];
YY = [];
CC = [];

for iPin = 1:nE
    xCnt = Pe(1, iPin);
    yCnt = Pe(2, iPin);
    
    if abs(yCnt) < rEps
        X = xCnt + xNN;
        Y = yCnt + yNN;
    elseif abs(xCnt * sqrt(3.) + yCnt) < rEps
        X = xCnt + xSW;
        Y = yCnt + ySW;
    else
        X = xCnt + x0;
        Y = yCnt + y0;
    end
    
    XX = [XX;X];
    YY = [YY;Y];
    CC = [CC;ones(1, 6) * Pe(5, iPin)];
end

if nE ~= 0
    patch(XX',YY',CC',CC','LineStyle','None');
end

end