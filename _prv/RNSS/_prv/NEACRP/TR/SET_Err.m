function [Tot_E, Max_E, Fin_E] = SET_Err(nTot_R, Tot_R, Max_R, Fin_R, Tot_M, Max_M, Fin_M, lMas)

Tot_E = zeros(2, nTot_R);
Max_E = zeros(1, 2);
Fin_E = zeros(1, 4);

if ~lMas
    return
end

for it = 1:nTot_R
    Tot_E(1, it) = Tot_R(1, it);
    Tot_E(2, it) = Tot_R(2, it) - Tot_M(2, it);
end

for it = 1:2
    Max_E(it) = Max_R(it) - Max_M(it);
end

for it = 1:4
    Fin_E(it) = Fin_R(it) - Fin_M(it);
end

end