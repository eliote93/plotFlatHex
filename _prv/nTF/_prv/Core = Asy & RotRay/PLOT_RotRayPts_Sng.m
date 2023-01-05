function PLOT_RotRayPts_Sng(Fn, jRot)

fid = fopen(Fn);

while  (~feof(fid))
    tline = fgetl(fid);
    Intro = textscan(tline, '%s', 100);
    iRot  = sscanf(Intro{1}{1}, '%d');
    ncRay = sscanf(Intro{1}{2}, '%d');
    
    if iRot ~= jRot
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
        
        PLOT_Seg(Pts(1:2, 1), Pts(1:2, 2), 1, 'k');
        
        jcRay = sscanf(Intro{1}{2}, '%d');
        Pts   = SORT_Pts(Pts, 2, 2);
        
        if jcRay > 0
            scatter(Pts(1, 1), Pts(2, 1), 'k');
        else
            scatter(Pts(1, 2), Pts(2, 2), 'k');
        end
    end
    
    tline = fgetl(fid);
end

end