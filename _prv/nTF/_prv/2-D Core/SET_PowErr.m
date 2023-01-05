function [Pe, nE, RMS, MAX] = SET_PowErr(Pm, mPin, Pn, nPin, aF2F, pF2F, maRng, mpRng, lHS, lROT, lErr, lRel)

%% INIT
Pe   = zeros(5, nPin);
KK   = zeros(1, 6);
lFld = boolean(zeros(1, mPin));
nE   = 0;
RMS  = 0.;
MAX  = 0.;

[aCnt]       = SET_Cnt(aF2F, maRng, 1);
[pCnt]       = SET_Cnt(pF2F, mpRng, 2);
[mCnt, lDum] = SET_GlbCnt(Pm, mPin, aCnt, pCnt, 1, false);

if lHS
    nFld = 6;
else
    nFld = 1;
end
%% PLOT : Pow Dst
lMC = true;

if ~lErr && lMC
    for jPin = 1:mPin
        if Pm(1, jPin) < 1E-7
            continue;
        end
        
        nE = nE + 1;
        
        Pe(1:2, nE) = mCnt(1:2, 1, jPin); % xCnt, yCnt
        Pe(  5, nE) = Pm(1, jPin);     % Pm
    end
    
    return
end

[nCnt, lBndy] = SET_GlbCnt(Pn, nPin, aCnt, pCnt, nFld, lROT);
%[Pn]          = SET_BndyPn(Pn, nPin, nCnt, lBndy, lHS, lROT);

if ~lErr && ~lMC
    for jPin = 1:nPin
        if Pn(1, jPin) < 1E-7
            continue;
        end
        
        nE = nE + 1;
        
        Pe(1:2, nE) = nCnt(1:2, 1, jPin); % xCnt, yCnt
        Pe(  5, nE) = Pn(1, jPin);     % Pm
    end
    
    return
end
%% SET : Err Pt
for iPin = 1:nPin
    if Pn(1, iPin) < 1E-3
        continue;
    end
    
    nM = 0;
    
    for jPin = 1:mPin
        if lFld(jPin) && ~lBndy(iPin)
            continue
        end
        
        for iFld = 1:nFld
            [lChk] = CHK_SamePts(mCnt(1:2, 1, jPin), nCnt(1:2, iFld, iPin));
            
            if lChk
                lFld(jPin) = true;
                
                nM     = nM + 1;
                KK(nM) = Pm(1, jPin);
                
                break
            end
        end
    end
    
    if nM == 0
        error('NO CORRESPONDING MC PIN');
    end
    
    if mod(iPin, 10) == 0
        fprintf('%d (%.2f%%) \n', iPin, 100. * iPin / nPin);
    end
    
    nE = nE + 1;
    
    Pe(1:2, nE) = nCnt(1:2, 1, iPin); % xCnt, yCnt
    Pe(  3, nE) = Pn(1, iPin);        % Pn
    Pe(  4, nE) = mean(KK(1:nM));     % Pm
end
%% NORM
nAvg = mean(Pe(3, 1:nE));
mAvg = mean(Pe(4, 1:nE));

Pe(3, :) = Pe(3, :) / nAvg;
Pe(4, :) = Pe(4, :) / mAvg;
%% SET : Pow ERR
if lRel
    for iPin = 1:nE
        DEL = 100 * (Pe(3, iPin) - Pe(4, iPin)) / Pe(4, iPin);
        RMS = RMS + DEL * DEL;
        MAX = max([MAX, abs(DEL)]);
        
        Pe(5, iPin) = DEL;
    end
else
    for iPin = 1:nE
        DEL = 100 * (Pe(3, iPin) - Pe(4, iPin));
        RMS = RMS + DEL * DEL;
        MAX = max([MAX, abs(DEL)]);
        
        Pe(5, iPin) = DEL;
    end
end

RMS = sqrt(RMS / nE);
end