function [Eqn] = SET_LineEqn(Pt01, Pt02)
% Eqn(1) * x + Eqn(2) * y = Eqn(3)

if abs(Pt01(1) - Pt02(1)) < 1E-7
    Eqn(1) = 1.;
    Eqn(2) = 0.;
    Eqn(3) = Pt01(1);
    
    return
end

tanv = (Pt02(2) - Pt01(2)) / (Pt02(1) - Pt01(1));

Eqn(1) = tanv;
Eqn(2) = -1.;
Eqn(3) = Eqn(1) * Pt01(1) + Eqn(2) * Pt01(2);

end

