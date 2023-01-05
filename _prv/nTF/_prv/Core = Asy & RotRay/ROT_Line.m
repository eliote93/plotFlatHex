function [Line] = ROT_Line(Eqn, theta, Nxt)
% Eqn(1) * x + Eqn(2) * y = Eqn(3)

Line = zeros(1, 3);

Slp(1) = -Eqn(2); % cosv
Slp(2) =  Eqn(1); % sinv

New(1:2) = ROT_Pt(Slp, theta);

Line(1) =  New(2); % sinv
Line(2) = -New(1); % -cosv
Line(3) =  Line(1) * Nxt(1) + Line(2) * Nxt(2);

end

