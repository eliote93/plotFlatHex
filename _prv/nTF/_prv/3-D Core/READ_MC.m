function [ Pm, maRng, mAsy, mpRng, mPin, maF2F, mpF2F, sdMax ] = READ_MC(Fm)

% ASSUME: Only fuel pins are tallied
fid     = fopen(Fm);
nMaxTmp = 100000;
mTmp    = zeros(7, nMaxTmp);
mPin    = 0;
%% READ : Power
while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 19
        continue
    end
    
    if ~strcmp(tline(1:5), '*Cell')
        Dum1 = tline(1:17);
        Dum2 = tline(19:Lgh);
        Lgh  = length(sscanf(Dum2, '%f'));
        
        if Lgh == 1
            if strcmp(Dum1, '* #define ASY_F2F')
                maF2F = sscanf(Dum2, '%f');
            end
            
            if strcmp(Dum1, '* #define ASY_PCH')
                maF2F = sscanf(Dum2, '%f') * sqrt(3.);
            end
            
            if strcmp(Dum1, '* #define PIN_F2F')
                mpF2F = sscanf(Dum2, '%f');
            end
            
            if strcmp(Dum1, '* #define PIN_PCH')
                mpF2F = sscanf(Dum2, '%f') * sqrt(3.);
            end
        end
        
        continue
    end
    
    if strcmp(tline(28:31), 'ACEL')
        break
    end
    
    mPin = mPin + 1;
    
    mTmp(1, mPin) = sscanf(tline(17:18), '%f'); % iax
    mTmp(2, mPin) = sscanf(tline(20:21), '%f'); % iay
    mTmp(3, mPin) = sscanf(tline(27:28), '%f'); % ipx
    mTmp(4, mPin) = sscanf(tline(30:31), '%f'); % ipy
    mTmp(5, mPin) = sscanf(tline(38:39), '%f'); % ipz
    mTmp(6, mPin) = sscanf(tline(90:100), '%f'); % pow
    mTmp(7, mPin) = sscanf(tline(117:123), '%f'); % Std. Dev.
end

if mPin > nMaxTmp
    error("READ MC")
end
%% CP
mpRng = (mTmp(4, mPin) + 1) / 2;
Pm    = zeros(7, mPin);
tPow  = mean(mTmp(6, 1:mPin));
sdMax = max(mTmp(7, :));
iasy  = 1;

for iPin = 1:mPin
    Pm(1, iPin) = mTmp(6, iPin) / tPow;
    Pm(2, iPin) = mTmp(5, iPin); % iz
    Pm(3, iPin) = mTmp(1, iPin); % iax
    Pm(4, iPin) = mTmp(2, iPin); % iay
    Pm(5, iPin) = iasy; % iasy
    Pm(6, iPin) = mTmp(3, iPin); % ipx
    Pm(7, iPin) = mTmp(4, iPin); % ipy
    
    if mTmp(1, iPin) ~= mTmp(1, iPin+1) || mTmp(2, iPin) ~= mTmp(2, iPin+1)
        iasy = iasy + 1;
    end
end

mAsy = Pm(5, mPin);

maRng = (max(Pm(4, :)) -  min(Pm(4, :)) + 2) / 2;
maCnt = (max(Pm(4, :)) +  min(Pm(4, :))) / 2;
maDel = maCnt - maRng;

for iPin = 1:mPin
    Pm(3, iPin) = Pm(3, iPin) - maDel; % iax
    Pm(4, iPin) = Pm(4, iPin) - maDel; % iay
end

fclose(fid);

end