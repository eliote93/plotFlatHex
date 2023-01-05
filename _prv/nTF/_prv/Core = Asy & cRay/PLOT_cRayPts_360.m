function PLOT_cRayPts_360(Fn, iAng)

fid = fopen(Fn);

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
    
    PLOT_Seg(Pts(1:2, 1), Pts(1:2, 2), 1, 'k');
    
    scatter(Pts(1, 1), Pts(2, 1), 'k');
    scatter(Pts(1, 2), Pts(2, 2), 'k');
end

end