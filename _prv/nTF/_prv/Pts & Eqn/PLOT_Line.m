function PLOT_Line(Eqn)

if abs(Eqn(2)) < 1E-7
    plot([Eqn(3) Eqn(3)], [-100. 100.])
else
    x1 = -100.;
    y1 = (Eqn(3) - x1 * Eqn(1)) / Eqn(2);
    
    x2 = 100.;
    y2 = (Eqn(3) - x2 * Eqn(1)) / Eqn(2);
    plot([x1 x2], [y1 y2])
end

end

