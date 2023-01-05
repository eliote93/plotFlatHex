function [Sgn] = SET_PtLineSgn(Pt, Eqn)

Sgn = Eqn(3) - Pt(1) * Eqn(1) - Pt(2) * Eqn(2);
Sgn = Sgn / abs(Sgn);

end

