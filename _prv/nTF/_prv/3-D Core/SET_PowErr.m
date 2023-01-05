function [Pe_RAD, Pe_AX, RMS_RAD, MAX_RAD, RMS_AX, MAX_AX, nE] = SET_PowErr(Pm_RAD, Pm_AX, mR, mZ, Pn_RAD, Pn_AX, nR, nZ, aF2F, pF2F, maRng, mpRng, l60, lROT, lErr, lRel)

%% INIT
RMS_RAD = 0.;
MAX_RAD = 0.;
RMS_AX  = 0.;
MAX_AX  = 0.;
Pe_AX   = zeros(1, nZ);
Pe_RAD  = zeros(5, nR);
KK      = zeros(1, 6);
lFld    = boolean(zeros(1, mR));
nE      = 0;

[aCnt]       = SET_Cnt(aF2F, maRng, 1);
[pCnt]       = SET_Cnt(pF2F, mpRng, 2);
[mCnt, lDum] = SET_GlbCnt(Pm_RAD, mR, aCnt, pCnt, 1, false);

if l60
    nFld = 6;
else
    nFld = 1;
end
%% PLOT : Pow Dst
if ~lErr
    for jPin = 1:mR
        if Pm_RAD(1, jPin) < 1E-7
            continue;
        end
        
        nE = nE + 1;
        
        Pe_RAD(1:2, nE) = mCnt(1:2, 1, jPin); % xCnt, yCnt
        Pe_RAD(  5, nE) = Pm_RAD(1, jPin);     % Pm
    end
    
    return
end

[nCnt, lBndy] = SET_GlbCnt(Pn_RAD, nR, aCnt, pCnt, nFld, lROT);
[Pn_RAD]      = SET_BndyPn(Pn_RAD, nR, nCnt, lBndy, l60, lROT);
%% ERR - AX
if mod(mZ, nZ) ~= 0
    error('WRONG AXIAL COMPARISON');
end

nNM = mZ / nZ;

for iz = 1:nZ
    izst = nNM * (iz-1) + 1;
    ized = nNM * iz;
    Pk   = sum(Pm_AX(izst:ized)) / nNM;
    
    if lRel
        DEL_AX = 100 * (Pn_AX(iz) - Pk) / Pk;
    else
        DEL_AX = 100 * (Pn_AX(iz) - Pk);
    end
    
    RMS_AX = RMS_AX + DEL_AX * DEL_AX;
    MAX_AX = max([MAX_AX, abs(DEL_AX)]);
    
    Pe_AX(iz) = DEL_AX;
end

RMS_AX = sqrt(RMS_AX / nZ);
%% ERR - RAD
for iPin = 1:nR
    if Pn_RAD(1, iPin) < 1E-3
        continue;
    end
    
    nM = 0;
    
    for jPin = 1:mR
        if lFld(jPin) && ~lBndy(iPin)
            continue
        end
        
        for iFld = 1:nFld
            [lChk] = CHK_SamePts(mCnt(1:2, 1, jPin), nCnt(1:2, iFld, iPin));
            
            if lChk
                lFld(jPin) = true;
                
                nM     = nM + 1;
                KK(nM) = Pm_RAD(1, jPin);
                
                break
            end
        end
    end
    
    if nM == 0
        error('NO CORRESPONDING MC PIN');
    end
    
    if mod(iPin, 10) == 0
        fprintf('%d \n', iPin);
        %fprintf('%d \n', lBndy(iPin));
        %fprintf('%d \n', nM);
    end
    
    nE = nE + 1;
    
    Pe_RAD(1:2, nE) = nCnt(1:2, 1, iPin); % xCnt, yCnt
    Pe_RAD(  3, nE) = Pn_RAD(1, iPin);    % Pn
    Pe_RAD(  4, nE) = mean(KK(1:nM));     % Pm
end
%% NORM
nAvg = mean(Pe_RAD(3, 1:nE));
mAvg = mean(Pe_RAD(4, 1:nE));

Pe_RAD(3, :) = Pe_RAD(3, :) / nAvg;
Pe_RAD(4, :) = Pe_RAD(4, :) / mAvg;
%% SET : Pow ERR
if lRel
    for iPin = 1:nE
        DEL = 100 * (Pe_RAD(3, iPin) - Pe_RAD(4, iPin)) / Pe_RAD(4, iPin);
        RMS_RAD = RMS_RAD + DEL * DEL;
        MAX_RAD = max([MAX_RAD, abs(DEL)]);
        
        Pe_RAD(5, iPin) = DEL;
    end
else
    for iPin = 1:nE
        DEL = 100 * (Pe_RAD(3, iPin) - Pe_RAD(4, iPin));
        RMS_RAD = RMS_RAD + DEL * DEL;
        MAX_RAD = max([MAX_RAD, abs(DEL)]);
        
        Pe_RAD(5, iPin) = DEL;
    end
end

RMS_RAD = sqrt(RMS_RAD / nE);
end