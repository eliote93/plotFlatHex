function[Pn, naRng, npRng, nPin, aF2F, pF2F, lHS, lROT] = READ_nTF(Fn)

fid   = fopen(Fn);
nTmp  = zeros(7, 100000);
nPin  = 0;
kF2F  = zeros(20); % ASSUME : Fuel pF2F is the only one
kPin  = zeros(20); % ASSUME : (nPin & pF2F)
naTyp = 1;
%% READ : aF2F & pF2F & l60 & lROT
while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 12
        continue
    end
    
    Intro = textscan(tline, '%s', 100);
    
    if length(Intro{1}) < 2
        continue
    end
    
    if Intro{1}{1} == "pitch"
        aF2F = sscanf(Intro{1}{2}, '%f');
    elseif Intro{1}{1} == "assembly"
        kF2F(naTyp) = sscanf(Intro{1}{9}, '%f');
        kPin(naTyp) = sscanf(Intro{1}{7}, '%d');
        
        naTyp = naTyp + 1;
    elseif Intro{1}{1} == "rad_conf"
        lHS  = sscanf(Intro{1}{2}, '%s') == "60";
        lROT = sscanf(Intro{1}{3}, '%s') == "ROT";
        
        break
    end
end
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
    end
end
%% READ : Power
while  (~feof(fid))
    Lgh = length(tline);
    
    if Lgh < 8
        break
    end
    
    if strcmp(tline(2:6), 'Plane')
        iz    = sscanf(tline(8:11), '%d');
        tline = fgetl(fid);
        iasy  = 0;
    end
    
    iasy = iasy + 1;
    iax  = sscanf(tline(20:25), '%d');
    iay  = sscanf(tline(27:32), '%d');
    
    tline = fgetl(fid);
    Intro = textscan(tline, '%s', 100);
    
    Sze   = size(Intro{1});
    tpRng = Sze(1);
    nLen  = 2*tpRng - 1;
    tPin  = nPin;
    
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
            nTmp(6, nPin) = ipx + max([0, ipy - tpRng]);
            nTmp(7, nPin) = ipy;
        end
        
        tline = fgetl(fid);
        Intro = textscan(tline, '%s', 100);
        Sze   = size(Intro{1});
    end
    
    if tPin == nPin
        iasy = iasy - 1;
    else
        npRng = tpRng;
        
        for iaTyp = 1:naTyp
            if kPin(iaTyp) == npRng
                pF2F = kF2F(iaTyp);
                
                break;
            end
        end
    end
end
%% CP
tPow = sum(nTmp(1, 1:nPin)) / nPin;
nTmp(1, :) = nTmp(1, :) / tPow;

Pn = nTmp(1:7, 1:nPin);

if lHS
    naRng = max(Pn(3, :));
else
    naRng = (max(Pn(4, :)) -  min(Pn(4, :)) + 2) / 2;
    naCnt = (max(Pn(4, :)) +  min(Pn(4, :))) / 2;
    naDel = naCnt - naRng;
    
    for iPin = 1:nPin
        Pn(3, iPin) = Pn(3, iPin) - naDel; % iax
        Pn(4, iPin) = Pn(4, iPin) - naDel; % iay
    end
end

fclose(fid);
end