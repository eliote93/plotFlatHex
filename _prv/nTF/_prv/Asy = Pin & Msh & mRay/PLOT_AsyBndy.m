function PLOT_AsyBndy(aoPch, n, a)

Pt = zeros(2, 7);

for i = 1:7
    Pt(1, i) = aoPch * cos((i-1)* pi / 3. + pi / 6);
    Pt(2, i) = aoPch * sin((i-1)* pi / 3. + pi / 6);
end

for i = 1:6
    PLOT_Seg(Pt(1:2, i), Pt(1:2, i+1), n, a);
end

end

