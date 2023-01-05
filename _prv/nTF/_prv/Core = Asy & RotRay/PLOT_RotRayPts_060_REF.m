function PLOT_RotRayPts_060_REF(Fn, iRot, aoF2F, nAsyCore)

fid = fopen(Fn);
Lgh = (nAsyCore - 1) * aoF2F;

Vtx = zeros(2, 4);
Eqn = zeros(3, 3);

Vtx(1:2, 1) = 0.;
Vtx(1:2, 4) = 0.;

Vtx(1, 2) = Lgh;
Vtx(2, 2) = 0.;
Vtx(1, 3) = Lgh * 0.5;
Vtx(2, 3) = -Lgh * 0.5 * sqrt(3.);

for iBndy = 1:3
    Eqn(1:3, iBndy) = SET_LineEqn(Vtx(1:2, iBndy), Vtx(1:2, iBndy+1));
    PLOT_Line(Eqn(1:3, iBndy), 2, 'b')
end

while  (~feof(fid))
    tline = fgetl(fid);
    Intro = textscan(tline, '%s', 100);
    ncRay = sscanf(Intro{1}{2}, '%d');
    
    jRot = sscanf(Intro{1}{1}, '%d');
    
    if jRot ~= iRot
        for icRay = 1:ncRay+1
            tline = fgetl(fid);
        end
        
        continue
    end
    
    for icRay = 1:ncRay
        tline = fgetl(fid);
        Intro = textscan(tline, '%s', 100);
        
        Pts(1, 1) = sscanf(Intro{1}{3}, '%f');
        Pts(2, 1) = sscanf(Intro{1}{4}, '%f');
        Pts(1, 2) = sscanf(Intro{1}{5}, '%f');
        Pts(2, 2) = sscanf(Intro{1}{6}, '%f');
        
        Pts    = SORT_Pts(Pts, 2, 2);
        RayEqn = SET_LineEqn(Pts(1:2, 1), Pts(1:2, 2));
        Sol    = SOLVE_LineFigure(RayEqn, Vtx, Eqn, 3);
        
        PLOT_Seg(Sol(1:2, 1), Sol(1:2, 2), 1, 'k');
        
        jcRay = sscanf(Intro{1}{2}, '%d');
        
        if jcRay > 0
            scatter(Sol(1, 1), Sol(2, 1), 'k');
        else
            scatter(Sol(1, 2), Sol(2, 2), 'k');
        end
    end
    
    tline = fgetl(fid);
end

end