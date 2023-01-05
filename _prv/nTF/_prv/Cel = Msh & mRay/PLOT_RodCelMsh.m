function PLOT_RodCelMsh(pF2F, nRng, sRng)

Cnt  = zeros(2);
Vtx  = zeros(2, 7);
Pts  = zeros(2, 6);
pPch = pF2F / sqrt(3.);

for iBndy = 1:7
    Ang = pi/3 * (2 - iBndy);
    
    Vtx(1, iBndy) = pPch * cos(Ang);
    Vtx(2, iBndy) = pPch * sin(Ang);
end

for iBndy = 1:6
    PLOT_Seg(Vtx(1:2, iBndy), Vtx(1:2, iBndy+1), 4, 'r')
    
    Pts(1:2, iBndy) = 0.5 * (Vtx(1:2, iBndy) + Vtx(1:2, iBndy+1));
end

for iBndy = 1:3
    PLOT_Seg(Vtx(1:2, iBndy), Vtx(1:2, iBndy+3), 1, 'k')
    PLOT_Seg(Pts(1:2, iBndy), Pts(1:2, iBndy+3), 1, 'k')
end

for iRng = 1:nRng
    PLOT_Circle(Cnt, sRng(iRng), 1, 'k')
end

xlim([-pF2F pF2F]);
ylim([-pF2F pF2F]);

end