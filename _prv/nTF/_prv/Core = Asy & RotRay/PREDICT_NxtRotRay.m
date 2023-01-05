function [Nxt, Line] = PREDICT_NxtRotRay(Pt, Eqn)

if abs(Pt(2)) < 1E-7
    theta = -pi / 3.;
else
    theta =  pi / 3.;
end

Nxt = ROT_Pt(Pt, theta);

scatter(Nxt(1), Nxt(2), 'k');

Line = ROT_Line(Eqn, theta, Nxt);

Bndy = zeros(2, 2);
Bndy(1, 1) = -100; Bndy(2, 1) = (Line(3) - Line(1) * Bndy(1, 1)) / Line(2);
Bndy(1, 2) =  100; Bndy(2, 2) = (Line(3) - Line(1) * Bndy(1, 2)) / Line(2);

plot([Bndy(1, 1), Bndy(1, 2)], [Bndy(2, 1), Bndy(2, 2)], 'r:', 'LineWidth', 1);

end

