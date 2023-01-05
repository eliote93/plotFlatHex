function [Pe_RAD, Pe_AX, RMS_RAD, MAX_RAD, RMS_AX, MAX_AX] = SET_PowErr(Pm_RAD, Pm_AX, mR, mZ, Pn_RAD, Pn_AX, nR, nZ)

RMS_RAD = 0.;
MAX_RAD = 0.;
RMS_AX  = 0.;
MAX_AX  = 0.;
%% ERR - RAD
Pe_RAD = zeros(7, nR);
Kn     = zeros(1, nR);
KK     = 0.;

for iPin = 1:nR
    if Pn_RAD(1, iPin) < 1E-7
        continue;
    end
    
    for jPin = 1:mR
        if Pm_RAD(3, jPin) == Pn_RAD(3, iPin) && Pm_RAD(4, jPin) == Pn_RAD(4, iPin) % iax, iay
            if Pm_RAD(6, jPin) == Pn_RAD(6, iPin) && Pm_RAD(7, jPin) == Pn_RAD(7, iPin) % ipx, ipy
                Kn(iPin) = jPin;
                KK = KK + Pm_RAD(1, jPin);
                
                break
            end
        end
    end
    
    if Kn(iPin) == 0
        error('NO CORRESPONDING MC PIN');
    end
end

KK = KK / nR;

for iPin = 1:nR
    jPin = Kn(iPin);
    Pk   = Pm_RAD(1, jPin) / KK;
    
    DEL_RAD = 100 * (Pn_RAD(1, iPin) - Pk) / Pk;
    RMS_RAD = RMS_RAD + DEL_RAD * DEL_RAD;
    MAX_RAD = max([MAX_RAD, abs(DEL_RAD)]);
    
    Pe_RAD(1,   iPin) = DEL_RAD;
    Pe_RAD(2:7, iPin) = Pn_RAD(2:7, iPin);
end

RMS_RAD = sqrt(RMS_RAD / nR);
%% ERR - AX
if mod(mZ, nZ) ~= 0
    error('WRONG AXIAL COMPARISON');
end

nNM   = mZ / nZ;
Pe_AX = zeros(1, nZ);

for iz = 1:nZ
    izst = nNM * (iz-1) + 1;
    ized = nNM * iz;
    Pk   = sum(Pm_AX(izst:ized)) / nNM;
    
    DEL_AX = 100 * (Pn_AX(iz) - Pk) / Pk;
    DEL_AX = (Pn_AX(iz) - Pk) / Pk;
    RMS_AX = RMS_RAD + DEL_AX * DEL_AX;
    MAX_AX = max([MAX_AX, abs(DEL_AX)]);
    
    Pe_AX(iz) = DEL_AX;
end

RMS_AX = sqrt(RMS_AX / nZ);

end