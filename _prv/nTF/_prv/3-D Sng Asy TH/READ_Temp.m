function [Tn, nPin] = READ_Temp(fid, nZ, AAA)

sLen = strlength(AAA);

%% FIND : Temp Tally
while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < sLen+2
        continue
    end
    
    if strcmp(tline(3:2+sLen), AAA)
        for iL = 1:5
            tline = fgetl(fid);
        end
        
        break
    end
end
%% READ : Fuel Pin Avg Temp
nPin = 0;
nTmp = zeros(7, 10000);

Intro = textscan(tline, '%s', 100);
npy   = length(Intro{1});
npx   = (npy + 1) / 2;
ixst  = 0;
xLen  = npx;

for ipy = 1:npy
    for iz = 1:nZ
        tline = fgetl(fid);
        
        for ipx = 1:xLen
            jxst = 15 + 8 * (ixst + ipx - 1);
            jxed = 15 + 8 * (ixst + ipx);
            
            Temp = sscanf(tline(jxst:jxed), '%f');
            
            if Temp < 1E-4
                continue
            end
            
            nPin = nPin + 1;
            
            nTmp(1, nPin) = Temp;
            nTmp(2, nPin) = iz;
            nTmp(3, nPin) = 1;  % iax
            nTmp(4, nPin) = 1;  % iay
            nTmp(5, nPin) = 1;  % iasy
            nTmp(6, nPin) = ipx + ixst;
            nTmp(7, nPin) = ipy;
        end
    end
    
    tline = fgetl(fid);
    
    if ipy < npx
        xLen = xLen + 1;
    else
        xLen = xLen - 1;
        ixst = ixst + 1;
    end
end
%% CP : Fuel Pin Avg Temp
Tn = zeros(7, nPin);

Tn(1:7, 1:nPin) = nTmp(1:7, 1:nPin);

end