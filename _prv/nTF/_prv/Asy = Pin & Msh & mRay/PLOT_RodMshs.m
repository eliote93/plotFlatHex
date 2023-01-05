function PLOT_RodMshs(pF2F, nPin, aiF2F, nRng, sRng, n, a)
% ASSUME : nSct = 12
% ASSUME : sRng is fixed as two

aiPch = aiF2F / sqrt(3.);
pPch  = pF2F  / sqrt(3.);

Vtx01 = zeros(2, 2*nPin - 1);
Vtx02 = zeros(2, 2*nPin - 1);

Vtx01(2, 1) =  aiPch;
Vtx02(2, 1) = -aiPch;

xDel = 1.5 * pPch;

for iPin = 1:nPin-1
    x = xDel * iPin;
    y = aiPch - x / sqrt(3.);
    
    Vtx01(1, 2*iPin) = x; Vtx01(2, 2*iPin) =  y;
    Vtx02(1, 2*iPin) = x; Vtx02(2, 2*iPin) = -y;
    
    Vtx01(1, 2*iPin+1) = -x; Vtx01(2, 2*iPin+1) =  y;
    Vtx02(1, 2*iPin+1) = -x; Vtx02(2, 2*iPin+1) = -y;
end

Ang = pi / 3.;

for iBndy = 1:3
    for iPin = 1:2*nPin-1
        PLOT_Seg(Vtx01(1:2, iPin), Vtx02(1:2, iPin), n, a);
        
        Vtx01(1:2, iPin) = RotPt(Vtx01(1:2, iPin), Ang);
        Vtx02(1:2, iPin) = RotPt(Vtx02(1:2, iPin), Ang);
    end
end

Vtx01 = zeros(2, 4*nPin - 3);
Vtx02 = zeros(2, 4*nPin - 3);

y    = aiF2F * 0.5;
xDel = pF2F  * 0.5;
yDel = pPch  * 1.5;

Vtx01(2, 1) =  y;
Vtx02(2, 1) = -y;

for iPin = 1:nPin-1
    Vtx01(1, 2*iPin) = xDel * iPin; Vtx01(2, 2*iPin) =  y;
    Vtx02(1, 2*iPin) = xDel * iPin; Vtx02(2, 2*iPin) = -y;
    
    Vtx01(1, 2*iPin+1) = -xDel * iPin; Vtx01(2, 2*iPin+1) =  y;
    Vtx02(1, 2*iPin+1) = -xDel * iPin; Vtx02(2, 2*iPin+1) = -y;
end

for iPin = nPin:(2*nPin-2)
    y = yDel * ((2*nPin-2) - iPin) + pPch;
    
    Vtx01(1, 2*iPin) = xDel * iPin; Vtx01(2, 2*iPin) =  y;
    Vtx02(1, 2*iPin) = xDel * iPin; Vtx02(2, 2*iPin) = -y;
    
    Vtx01(1, 2*iPin+1) = -xDel * iPin; Vtx01(2, 2*iPin+1) =  y;
    Vtx02(1, 2*iPin+1) = -xDel * iPin; Vtx02(2, 2*iPin+1) = -y;
end

Ang = -pi/6.;

for iPin = 1:4*nPin - 3
    Vtx01(1:2, iPin) = RotPt(Vtx01(1:2, iPin), Ang);
    Vtx02(1:2, iPin) = RotPt(Vtx02(1:2, iPin), Ang);
end

Ang = -pi/3.;

for iBndy = 1:3
    for iPin = 1:4*nPin - 3
        PLOT_Seg(Vtx01(1:2, iPin), Vtx02(1:2, iPin), n, a)
        
        Vtx01(1:2, iPin) = RotPt(Vtx01(1:2, iPin), Ang);
        Vtx02(1:2, iPin) = RotPt(Vtx02(1:2, iPin), Ang);
    end
end

nLgh = 2 * nPin - 1;
Cnt  = zeros(2);
xDel = pPch * 1.5;
yDel = pF2F * 0.5;

xSt = 1;
xEd = nPin;


for iy = 1:nLgh
    for ix = xSt:xEd
        Cnt(1) =  xDel * (ix - iy);
        Cnt(2) = -yDel * (ix + iy - 2 * nPin);
        
        for iRng = 1:nRng
            PLOT_Circle(Cnt, sRng(iRng), n, a);
        end
    end
    
    if iy < nPin
        xEd = xEd + 1;
    else
        xSt = xSt + 1;
    end
end

end