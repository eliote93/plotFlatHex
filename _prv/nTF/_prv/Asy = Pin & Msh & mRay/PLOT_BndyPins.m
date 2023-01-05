function PLOT_BndyPins(pF2F, nPin, aiF2F, n, a)

pPch = pF2F / sqrt(3.);

Pt(1) = cos(pi / 3.) * aiF2F * 0.5;
Pt(2) = sin(pi / 3.) * aiF2F * 0.5;
Pt(3) = cos(pi / 3.) * (1.5 * nPin - 2) * pPch;
Pt(4) = sin(pi / 3.) * (1.5 * nPin - 2) * pPch;

nPt = (nPin - mod(nPin, 2))/2;

Vtx = zeros(8, nPt);
Ang = -pi / 6;

for iDir = 1:nPt
    Vtx(1, iDir) = Pt(1) + pF2F * cos(Ang) * (iDir - 1 + 0.5 * mod(nPin, 2));
    Vtx(2, iDir) = Pt(2) + pF2F * sin(Ang) * (iDir - 1 + 0.5 * mod(nPin, 2));
    Vtx(3, iDir) = Pt(1) - pF2F * cos(Ang) * (iDir - 1 + 0.5 * mod(nPin, 2));
    Vtx(4, iDir) = Pt(2) - pF2F * sin(Ang) * (iDir - 1 + 0.5 * mod(nPin, 2));
    
    Vtx(5, iDir) = Pt(3) + pF2F * cos(Ang) * (iDir - 1 + 0.5 * mod(nPin, 2));
    Vtx(6, iDir) = Pt(4) + pF2F * sin(Ang) * (iDir - 1 + 0.5 * mod(nPin, 2));
    Vtx(7, iDir) = Pt(3) - pF2F * cos(Ang) * (iDir - 1 + 0.5 * mod(nPin, 2));
    Vtx(8, iDir) = Pt(4) - pF2F * sin(Ang) * (iDir - 1 + 0.5 * mod(nPin, 2));
end

Ang = -pi / 3.;

for iBndy = 1:6
    for iDir = 1:nPt
        PLOT_Seg(Vtx(1:2, iDir), Vtx(5:6, iDir), n, a);
        PLOT_Seg(Vtx(3:4, iDir), Vtx(7:8, iDir), n, a);
        
        Vtx(1:2, iDir) = RotPt(Vtx(1:2, iDir), Ang);
        Vtx(3:4, iDir) = RotPt(Vtx(3:4, iDir), Ang);
        Vtx(5:6, iDir) = RotPt(Vtx(5:6, iDir), Ang);
        Vtx(7:8, iDir) = RotPt(Vtx(7:8, iDir), Ang);
    end
end

end

