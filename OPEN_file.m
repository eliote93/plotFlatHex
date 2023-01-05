function [fid] = OPEN_file(fn, lerr, lrel, tn)

if tn == 'XY'
    if lerr
        if lrel
            gn = strcat(fn, '_rel_xy.out'); fid = fopen(gn);
        else
            gn = strcat(fn, '_abs_xy.out'); fid = fopen(gn);
        end
    else
        gn = strcat(fn, '_xy.out'); fid = fopen(gn);
    end
else
    if lerr
        if lrel
            gn = strcat(fn, '_rel_z.out'); fid = fopen(gn);
        else
            gn = strcat(fn, '_abs_z.out'); fid = fopen(gn);
        end
    else
        gn = strcat(fn, '_z.out'); fid = fopen(gn);
    end
end

if fid < 0
    error('WRONG FILE NAME')
end

end