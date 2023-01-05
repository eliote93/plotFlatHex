function PLOT_Core_360(aoF2F, nAsyCore)

aoPch = aoF2F / sqrt(3.);

Vtx = zeros(2, 7);

for iBndy = 1:7
    Ang = pi/6. - (pi/3.) * (1 - iBndy);
    
    Vtx(1, iBndy) = aoPch * cos(Ang);
    Vtx(2, iBndy) = aoPch * sin(Ang);
end

naSt = 1;
naEd = nAsyCore;

for iay = 1:2*nAsyCore-1
    for iax = naSt:naEd
        Cnt(1) = aoF2F * ((iax - nAsyCore) + 0.5 * (nAsyCore - iay));
        Cnt(2) = aoPch * 1.5 * (nAsyCore - iay);
        
        for iBndy = 1:6
            PLOT_Segs(Cnt, Vtx, 7, 2, 'r');
        end
    end
    
    if iay < nAsyCore
        naEd = naEd + 1;
    else
        naSt = naSt + 1;
    end
end

end
