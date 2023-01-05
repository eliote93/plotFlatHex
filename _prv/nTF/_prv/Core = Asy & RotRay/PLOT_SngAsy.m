function PLOT_SngAsy(aoF2F)

Theta = pi / 2.;
aoPch = aoF2F / sqrt(3.);

Vtx = zeros(2, 7);
Cnt = zeros(2, 2);

for iBndy = 1:7
    Vtx(1, iBndy) = cos(Theta)*aoPch;
    Vtx(2, iBndy) = sin(Theta)*aoPch;
    
    Theta = Theta - pi / 3.;
end

PLOT_Segs(Cnt, Vtx, 7, 2, 'r');

end

