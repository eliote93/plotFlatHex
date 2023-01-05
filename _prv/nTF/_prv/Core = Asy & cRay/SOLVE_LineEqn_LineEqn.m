function [Sol] = SOLVE_LineEqn_LineEqn(Eqn01, Eqn02)

hEps = 1E-7;

if abs(Eqn01(1)) > hEps
  Tmp = Eqn02(2) - Eqn02(1) * Eqn01(2) / Eqn01(1);
  
  if abs(Tmp) > hEps
    Sol(2) = (Eqn02(3) - Eqn02(1) * Eqn01(3) / Eqn01(1)) / Tmp;
    Sol(1) = (Eqn01(3) - Eqn01(2) * Sol(2)) / Eqn01(1);
  else
    error('SOLVE : Line Eqn');
  end
else
  if abs(Eqn02(1)) > hEps
    Sol(2) = Eqn01(3) / Eqn01(2);
    Sol(1) = (Eqn02(3) - Eqn02(2) * Eqn01(3) / Eqn01(2)) / Eqn02(1);
  else
    error('SOLVE : Line Eqn');
  end
end

end

