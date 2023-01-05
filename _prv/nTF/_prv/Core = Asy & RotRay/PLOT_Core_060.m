function PLOT_Core_060(aoF2F, nAsyCore)

aoPch = aoF2F / sqrt(3.);

Vtx = zeros(2, 7);

for iBndy = 1:7
    Ang = pi/6. - (pi/3.) * (1 - iBndy);
    
    Vtx(1, iBndy) = aoPch * cos(Ang);
    Vtx(2, iBndy) = aoPch * sin(Ang);
end

naEd = nAsyCore;

for iay = 1:nAsyCore
    for iax = 1:naEd
        Cnt(1) = aoF2F * ((iax - 1) + 0.5 * (iay - 1));
        Cnt(2) = aoPch * 1.5 * (1 - iay);
        
        for iBndy = 1:6
            PLOT_Segs(Cnt, Vtx, 7, 2, 'r');
        end
    end
    
    naEd = naEd - 1;
end

xlim([-aoF2F * 0.5 * 1.1, aoF2F * (nAsyCore - 0.5) * 1.1]);
ylim([-aoPch * 1.5 * (nAsyCore - 1) - aoPch * 1.1, aoPch * 1.1]);

end