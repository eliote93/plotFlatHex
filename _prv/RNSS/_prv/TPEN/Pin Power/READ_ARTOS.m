function[nPin, pF2F, Pa] = READ_ARTOS(Fa)

fid = fopen(Fa);
npa = 0;
%% FIND : Tally
while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 23
        continue
    end
    
    if strcmp(tline(2:23), 'Pin Power Distribution')
        break
    else
        Intro = textscan(tline, '%s', 100);
        
        if Intro{1}{1} == "pinpower"
            nPin = sscanf(Intro{1}{4}, '%f');
            pF2F = sscanf(Intro{1}{5}, '%f');
        end
    end
end

if feof(fid)
    error('READ : ARTOS 1')
end
%% READ : Flx Poly.
nRng = 2*nPin - 1;
pTmp = zeros(nRng, nRng, 10);

while  (~feof(fid))
    tline = fgetl(fid);
    tline = fgetl(fid);
    
    Intro = textscan(tline, '%s', 100);
    
    if Intro{1}{1} ~= "Asy"
        break;
    end
    
    npa = npa + 1;
    
    tline = fgetl(fid);
    
    ixb = 1;
    ixe = nPin;
        
    for iy = 1:nRng
        tline = fgetl(fid);
        Intro = textscan(tline, '%s', 100);
                
        for ix = ixb:ixe
            pTmp(ix, iy, npa) = sscanf(Intro{1}{ix - ixb + 1}, '%f');
        end
        
        if iy < nPin
            ixe = ixe + 1;
        else
            ixb = ixb + 1;
        end
    end
end

if feof(fid)
    error('READ : ARTOS 2')
end
%% CP
Pa = zeros(nRng, nRng, npa);

Pa(1:nRng, 1:nRng, 1:npa) = pTmp(1:nRng, 1:nRng, 1:npa);

fclose(fid);
end