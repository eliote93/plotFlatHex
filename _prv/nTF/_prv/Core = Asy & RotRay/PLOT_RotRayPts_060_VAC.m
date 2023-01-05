function PLOT_RotRayPts_060_VAC(Fn, iAng)

fid = fopen(Fn);

nAzm = zeros(24, 1); % for debugging

Eqn01 = [sqrt(3.) 1. 0.];
Eqn02 = [0. -1. 0.];

PLOT_Line(Eqn01, 2, 'b')
PLOT_Line(Eqn02, 2, 'b')

while  (~feof(fid))
    tline = fgetl(fid);
    Intro = textscan(tline, '%s', 100);
    ncRay = sscanf(Intro{1}{2}, '%d');
    
    jAng = sscanf(Intro{1}{3}, '%d');
    
    nAzm(jAng) = nAzm(jAng) + 1;
    
    kAng = sscanf(Intro{1}{4}, '%d');
    
    if kAng ~= jAng
        nAzm(kAng) = nAzm(kAng) + 1;
    end
    
    if jAng ~= iAng
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
        
        Pts = SORT_Pts(Pts, 2, 2);
        Eqn = SET_LineEqn(Pts(1:2, 1), Pts(1:2, 2));
        
        if SET_PtLineSgn(Pts(1:2, 1), Eqn01) > 0
            Pts(1:2, 1) = SOLVE_LineEqn_LineEqn(Eqn01, Eqn); % SW
        end
        
        if SET_PtLineSgn(Pts(1:2, 2), Eqn02) > 0
            Pts(1:2, 2) = SOLVE_LineEqn_LineEqn(Eqn02, Eqn); % NN
        end
        
        if SET_PtLineSgn(Pts(1:2, 2), Eqn01) > 0
            Pts(1:2, 2) = SOLVE_LineEqn_LineEqn(Eqn01, Eqn); % SW
        end
        
        PLOT_Seg(Pts(1:2, 1), Pts(1:2, 2), 1, 'k');
        
        jcRay = sscanf(Intro{1}{2}, '%d');
        
        if jcRay > 0
            scatter(Pts(1, 1), Pts(2, 1), 'k');
        else
            scatter(Pts(1, 2), Pts(2, 2), 'k');
        end
    end
    
    tline = fgetl(fid);
end

end