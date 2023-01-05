function[Pn, nAsy, npRng, nPin] = READ_nTF(Fn)

fid  = fopen(Fn);
nTmp = zeros(3, 100000);
iaxy = 0;
nPin = 0;
%% FIND : Power Lines
while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 2
        continue
    end
    
    Intro = textscan(tline, '%s', 100);
    
    s1 = Intro{1}{1};
    tf = strcmp(s1, 'Assembly');
    
    if tf
        break
    end
end
%% READ : Power
while (tf)
    tline = fgetl(fid);
    Intro = textscan(tline, '%s', 100);
    
    Sze   = size(Intro{1});
    npRng = Sze(1);
    nLen  = 2*npRng - 1;
    tPin  = nPin;
    iaxy  = iaxy + 1;
    
    for iy = 1:nLen
        for ix = 1:Sze(1)
            Pow = sscanf(Intro{1}{ix}, '%f');
            
            if Pow < 1E-4
                continue
            end
            
            nPin = nPin + 1;
            
            nTmp(1, nPin) = ix;
            nTmp(2, nPin) = iy;
            nTmp(3, nPin) = iaxy;
            nTmp(4, nPin) = Pow;
        end
        
        tline = fgetl(fid);
        Intro = textscan(tline, '%s', 100);
        Sze   = size(Intro{1});
    end
    
    if tPin == nPin
        iaxy = iaxy - 1;
    end
    
    if Sze(1) == 0 || ~strcmp(Intro{1}{1}, 'Assembly')
        break
    end
end
%% CP
tPow = sum(nTmp(4, 1:nPin)) / nPin;
Pn   = zeros(4, nPin);

for iPin = 1:nPin
    Pn(1, iPin) = nTmp(1, iPin); % ipx
    Pn(2, iPin) = nTmp(2, iPin); % ipy
    Pn(3, iPin) = nTmp(3, iPin); % iaxy
    Pn(4, iPin) = nTmp(4, iPin) / tPow;
    
    if Pn(2, iPin) > npRng
        Pn(1, iPin) = Pn(1, iPin) + (Pn(2, iPin) - npRng);
    end
end

nAsy = Pn(3, nPin);

fclose(fid);
end