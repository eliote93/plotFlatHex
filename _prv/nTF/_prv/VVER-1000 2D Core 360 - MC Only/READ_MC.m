function [ Pm, mAsy, mpRng, mPin, sdMax ] = READ_MC(Fm)

fid  = fopen(Fm);
mTmp = zeros(6, 100000);
mPin = 0;
%% READ
while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 31
        continue
    end
    
    if ~strcmp(tline(1:5), '*Cell')
        continue
    end
    
    if strcmp(tline(28:31), 'ACEL')
        break
    end
    
    mPin = mPin + 1;
    
    mTmp(1, mPin) = sscanf(tline(18:19), '%f'); % iax
    mTmp(2, mPin) = sscanf(tline(21:22), '%f'); % iay
    mTmp(3, mPin) = sscanf(tline(28:29), '%f'); % ipx
    mTmp(4, mPin) = sscanf(tline(31:32), '%f'); % ipy
    mTmp(5, mPin) = sscanf(tline(88:98), '%f'); % Pow
    mTmp(6, mPin) = sscanf(tline(115:121), '%f'); % Std. Dev. of Pow
end

tPow  = sum(mTmp(5, 1:mPin)) / mPin;
mpRng = (mTmp(3, mPin) + 1) / 2;
sdMax = max(mTmp(6, 1:mPin));

if mpRng < 1
    error('READ : MC INPUT');
end
%% CP

% ASSUME: Only fuel pins are tallied
Pm   = zeros(7, mPin);
iaxy = 1;

for iPin = 1:mPin
    Pm(1, iPin) = mTmp(5, iPin) / tPow; % Power
    Pm(2, iPin) = 1; % iz
    Pm(3, iPin) = mTmp(1, iPin); % iax
    Pm(4, iPin) = mTmp(2, iPin); % iay
    Pm(5, iPin) = iaxy;
    Pm(6, iPin) = mTmp(3, iPin); % ipx
    Pm(7, iPin) = mTmp(4, iPin); % ipy
    
    if (mTmp(1, iPin) ~= mTmp(1, iPin+1)) || (mTmp(2, iPin) ~= mTmp(2, iPin+1))
        iaxy = iaxy + 1;
    end
end

mAsy = Pm(5, mPin);

fclose(fid);

end