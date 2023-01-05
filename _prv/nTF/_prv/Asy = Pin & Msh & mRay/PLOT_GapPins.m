function PLOT_GapPins(aiF2F, aoF2F, n, a)

aiPch = aiF2F / sqrt(3.);
aoPch = aoF2F / sqrt(3.);

Pts = zeros(2, 4);

for iBndy = 1:6
    Ang = pi / 2. + (1 - iBndy) * pi / 3.;
    ri  = aiPch;
    ro  = aoPch;
    
    Pts(1, 1) = ri * cos(Ang); Pts(2, 1) = ri * sin(Ang);
    Pts(1, 2) = ro * cos(Ang); Pts(2, 2) = ro * sin(Ang);
    
    PLOT_Seg(Pts(1:2, 1), Pts(1:2, 2), n, a);
            
    Ang = (2 - iBndy) * pi / 3.;
    ri  = aiF2F * 0.5;
    ro  = aoF2F * 0.5;
    
    Pts(1, 1) = ri * cos(Ang); Pts(2, 1) = ri * sin(Ang);
    Pts(1, 2) = ro * cos(Ang); Pts(2, 2) = ro * sin(Ang);
    
    PLOT_Seg(Pts(1:2, 1), Pts(1:2, 2), n, a);
end

for iBndy = 1:6
    Ang = pi / 2. + (1 - iBndy) * pi / 3.;
    ri  = aiPch;
    ro  = aoPch;
    
    Pts(1, 1) = ri * cos(Ang); Pts(2, 1) = ri * sin(Ang);
    Pts(1, 2) = ro * cos(Ang); Pts(2, 2) = ro * sin(Ang);
    
    Ang = Ang + pi / 3.;
    
    Pts(1, 3) = ri * cos(Ang); Pts(2, 3) = ri * sin(Ang);
    Pts(1, 4) = ro * cos(Ang); Pts(2, 4) = ro * sin(Ang);
    
    PLOT_Seg(Pts(1:2, 1), Pts(1:2, 3), n, a);
    PLOT_Seg(Pts(1:2, 2), Pts(1:2, 4), n, a);
end

end

