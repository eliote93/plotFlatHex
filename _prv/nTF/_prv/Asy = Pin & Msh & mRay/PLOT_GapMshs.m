function PLOT_GapMshs(pF2F, nPin, aiF2F, aoF2F, n, a)

% ASSUME : sHgt is fixed as the HALF of gHgt
% ASSUME : nHor is fixed as 8

aiPch = aiF2F / sqrt(3.);
aoPch = aoF2F / sqrt(3.);
gHgt  = (aoF2F - aiF2F) * 0.5;
y1    =  gHgt * 0.5;
y2    = -gHgt * 0.5;
nHor  = 8;
xDel  = pF2F / nHor;

Vtx01 = zeros(2, nHor * nPin);
Vtx02 = zeros(2, nHor * nPin);
nMsh  = 1;

for iMsh = 1:nHor * nPin
    x = xDel * iMsh;
    
    if x > aiPch * 0.5
        break
    end
    
    Vtx01(1, 2*iMsh-1) = x;  Vtx02(1, 2*iMsh-1) = x;
    Vtx01(2, 2*iMsh-1) = y1; Vtx02(2, 2*iMsh-1) = y2;
    
    Vtx01(1, 2*iMsh) = -x; Vtx02(1, 2*iMsh) = -x;
    Vtx01(2, 2*iMsh) = y1; Vtx02(2, 2*iMsh) = y2;
    
    nMsh = nMsh + 2;
end

Vtx01(1, nMsh) =  (aiPch + aoPch) * 0.25;
Vtx02(1, nMsh) = -(aiPch + aoPch) * 0.25;

Ang   = pi / 3.;
Lgh   = (aiF2F + aoF2F) * 0.25;
Pt(1) = Lgh * cos(Ang);
Pt(2) = Lgh * sin(Ang);
Ang   = -pi / 6.;

for iMsh = 1:nMsh
    Vtx01(1:2, iMsh) = RotPt(Vtx01(1:2, iMsh), Ang);
    Vtx02(1:2, iMsh) = RotPt(Vtx02(1:2, iMsh), Ang);
    
    for iCor = 1:2
        Vtx01(iCor, iMsh) = Vtx01(iCor, iMsh) + Pt(iCor);
        Vtx02(iCor, iMsh) = Vtx02(iCor, iMsh) + Pt(iCor);
    end
end

Ang = -pi / 3.;

for iBndy = 1:6
    for iMsh = 1:nMsh
        PLOT_Seg(Vtx01(1:2, iMsh), Vtx02(1:2, iMsh), n, a);
        
        Vtx01(1:2, iMsh) = RotPt(Vtx01(1:2, iMsh), Ang);
        Vtx02(1:2, iMsh) = RotPt(Vtx02(1:2, iMsh), Ang);
    end
end

end

