function [Sol] = SOLVE_LineFigure(RayEqn, Vtx, Eqn, nBndy)

Sol = zeros(2, 2);
nPt = 0;

for iBndy = 1:nBndy
    Val01 = RayEqn(3) - RayEqn(1) * Vtx(1, iBndy)   - RayEqn(2) * Vtx(2, iBndy);
    Val02 = RayEqn(3) - RayEqn(1) * Vtx(1, iBndy+1) - RayEqn(2) * Vtx(2, iBndy+1);
    
    if Val01*Val02 > 0
        continue
    end
    
    nPt = nPt + 1;
    
    Sol(1:2, nPt) = SOLVE_LineEqn_LineEqn(RayEqn, Eqn(1:3, iBndy));
end

if nPt ~= 2
    PLOT_Line(RayEqn, 1, 'k')
    error('SOLVE : Line Figure');
end

if Sol(2, 1) > Sol(2, 2)
    Tmp(1:2) = Sol(1:2, 1);
    Sol(1:2, 1) = Sol(1:2, 2);
    Sol(1:2, 2) = Tmp(1:2);
end

end

