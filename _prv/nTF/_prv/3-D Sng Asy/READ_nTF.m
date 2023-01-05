function[Pn, nRng, nPin, pF2F] = READ_nTF(Fn)

fid  = fopen(Fn);
nTmp = zeros(7, 100000);
nPin = 0;
%% FIND : Power Tally
while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 17
        continue
    end
    
    if strcmp(tline(3:17), 'Local Pin Power')
        for i = 1:5
            tline = fgetl(fid);
        end
        
        break
    else
        Intro = textscan(tline, '%s', 100);
        
        if Intro{1}{1} == "assembly"
            pF2F = sscanf(Intro{1}{9}, '%f');
        end
    end
end
%% READ : Power
while  (~feof(fid))
    Lgh = length(tline);
    
    if Lgh < 8
        break
    end
    
    if strcmp(tline(2:6), 'Plane')
        iz = sscanf(tline(8:11), '%d');
        tline = fgetl(fid);
    end
    
    iasy = sscanf(tline(10:13), '%d');
    iax  = sscanf(tline(20:25), '%d');
    iay  = sscanf(tline(27:32), '%d');
    
    tline = fgetl(fid);
    Intro = textscan(tline, '%s', 100);
    
    Sze  = size(Intro{1});
    nRng = Sze(1);
    nLen = 2*nRng - 1;
    
    for ipy = 1:nLen
        for ipx = 1:Sze(1)
            Pow = sscanf(Intro{1}{ipx}, '%f');
            
            if Pow < 1E-4
                continue
            end
            
            nPin = nPin + 1;
            
            nTmp(1, nPin) = Pow;
            nTmp(2, nPin) = iz;
            nTmp(3, nPin) = iax;
            nTmp(4, nPin) = iay;
            nTmp(5, nPin) = iasy;
            nTmp(6, nPin) = ipx + max([0, ipy - nRng]);
            nTmp(7, nPin) = ipy;
        end
        
        tline = fgetl(fid);
        Intro = textscan(tline, '%s', 100);
        Sze   = size(Intro{1});
    end
end
%% CP
tPow = sum(nTmp(1, 1:nPin)) / nPin;
nTmp(1, :) = nTmp(1, :) / tPow;

Pn = nTmp(1:7, 1:nPin);

fclose(fid);

end