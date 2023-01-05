function PLOT_cRayPts_060_VAC(Fn, iAng)

fid = fopen(Fn);

Eqn01 = [sqrt(3.) 1. 0.];
Eqn02 = [0. 1. 0.];

PLOT_Line(Eqn01, 2, 'b')
PLOT_Line(Eqn02, 2, 'b')

while  (~feof(fid))
    tline = fgetl(fid);
    Intro = textscan(tline, '%s', 100);
    
    if sscanf(Intro{1}{1}, '%d') ~= iAng
        continue
    end
    
    Pts(1, 1) = sscanf(Intro{1}{3}, '%f');
    Pts(2, 1) = sscanf(Intro{1}{4}, '%f');
    Pts(1, 2) = sscanf(Intro{1}{5}, '%f');
    Pts(2, 2) = sscanf(Intro{1}{6}, '%f');
    
    Eqn = SET_LineEqn(Pts(1:2, 1), Pts(1:2, 2));
    
    Sol01 = SOLVE_LineEqn_LineEqn(Eqn01, Eqn);
    Sol02 = SOLVE_LineEqn_LineEqn(Eqn02, Eqn);
    
    if Sol01(2) > Pts(2, 1)
        Fin01(1:2) = Sol01(1:2);
    else
        Fin01(1:2) = Pts(1:2, 1);
    end
    
    if Sol02(2) < Pts(2, 2)
        Fin02(1:2) = Sol02(1:2);
    else
        Fin02(1:2) = Pts(1:2, 2);
    end
    
    PLOT_Seg(Fin01(1:2), Fin02(1:2), 1, 'k');
    
    scatter(Pts(1, 1), Pts(2, 1), 'k');
    scatter(Pts(1, 2), Pts(2, 2), 'k');
end

end