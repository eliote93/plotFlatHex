function [ Pm, mpRng, mPin, sdMax ] = READ_MC(Fm)

fid     = fopen(Fm);
nMaxTmp = 10000;
mTmp    = zeros(5, nMaxTmp);
mPin    = 0;
%% READ : Power
while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 5
        continue
    end
    
    if ~strcmp(tline(1:5), '*Cell')
        continue
    end
    
    mPin = mPin + 1;
    
    mTmp(1, mPin) = sscanf(tline(25:26), '%f'); % ipx
    mTmp(2, mPin) = sscanf(tline(28:29), '%f'); % ipy
    mTmp(3, mPin) = sscanf(tline(36:37), '%f'); % ipz
    mTmp(4, mPin) = sscanf(tline(88:98), '%f'); % pow
    mTmp(5, mPin) = sscanf(tline(115:121), '%f'); % Std. Dev.
end

if mPin > nMaxTmp
    error("READ MC")
end
%% CP
mpRng = (mTmp(1, mPin) + 1) / 2;
Pm    = zeros(7, mPin);
tPow  = mean(mTmp(4, 1:mPin));
sdMax = max(mTmp(5, :));

for iPin = 1:mPin
    Pm(1, iPin) = mTmp(4, iPin) / tPow;
    Pm(2, iPin) = mTmp(3, iPin); % iz
    Pm(3, iPin) = 1; % iax
    Pm(4, iPin) = 1; % iay
    Pm(5, iPin) = 1; % iasy
    Pm(6, iPin) = mTmp(1, iPin); % ipx
    Pm(7, iPin) = mTmp(2, iPin); % ipy
end

fclose(fid);

end