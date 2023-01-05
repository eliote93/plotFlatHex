function[aF2F, npa, Poly] = READ_ARTOS(Fn)

fid  = fopen(Fn);
kTmp = zeros(9, 2, 10);
npa  = 0;
%% FIND : Tally
while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 23
        continue
    end
    
    if strcmp(tline(2:23), 'Node Flux Distribution')
        break
    else
        Intro = textscan(tline, '%s', 100);
        
        if Intro{1}{1} == "grid_hex"
            aF2F = sscanf(Intro{1}{2}, '%f');
        end
    end
end

if feof(fid)
    error('READ : ARTOS 1')
end
%% READ : Flx Poly.
while  (~feof(fid))
    tline = fgetl(fid);
    tline = fgetl(fid);
    
    Intro = textscan(tline, '%s', 100);
    
    if Intro{1}{1} ~= "Asy"
        break;
    end
    
    npa = npa + 1;
    
    tline = fgetl(fid);
    tline = fgetl(fid);
    
    for ind = 1:6
        tline = fgetl(fid);
        
        for ik = 1:9
            tline = fgetl(fid);
            Intro = textscan(tline, '%s', 100);
            kTmp(ik, 1, ind, npa) = sscanf(Intro{1}{2}, '%f');
            kTmp(ik, 2, ind, npa) = sscanf(Intro{1}{3}, '%f');
        end
    end
end

if feof(fid)
    error('READ : ARTOS 2')
end
%% CP
Poly = zeros(9, 2, 6, npa);

Poly(1:9, 1:2, 1:6, 1:npa) = kTmp(1:9, 1:2, 1:6, 1:npa);

fclose(fid);
end