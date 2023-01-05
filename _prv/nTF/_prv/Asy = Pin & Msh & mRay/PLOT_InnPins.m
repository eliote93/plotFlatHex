function PLOT_InnPins(pF2F, nPin, n, a)

mPin = nPin - 1;
pPch = pF2F / sqrt(3.);
nLgh = 2 * mPin - 1;

Vtx = zeros(2, 7);
Cnt = zeros(2);

for iBndy = 1:7
    Ang = (2 - iBndy) * pi / 3.;
    
    Vtx(1, iBndy) = pPch * cos(Ang);
    Vtx(2, iBndy) = pPch * sin(Ang);
end

xDel = pPch * 1.5;
yDel = pF2F * 0.5;

xEd = mPin;
xSt = 1;

for iy = 1:nLgh
    for ix = xSt:xEd
        Cnt(1) =  xDel * (ix - iy);
        Cnt(2) = -yDel * (ix + iy - 2 * mPin);
        
        for iBndy = 1:6
            Pt(1:2, 1) = Vtx(1:2, iBndy)     + Cnt(1:2, 1);
            Pt(1:2, 2) = Vtx(1:2, iBndy + 1) + Cnt(1:2, 1);
            
            PLOT_Seg(Pt(1:2, 1), Pt(1:2, 2), n, a);
        end
    end
    
    if iy < mPin
        xEd = xEd + 1;
    else
        xSt = xSt + 1;
    end
end

end

