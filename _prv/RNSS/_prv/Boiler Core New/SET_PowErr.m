function [Prd_E, Pax_E, Max_Rd, RMS_Rd, Max_Ax, RMS_Ax, Pf] = SET_PowErr(nZ, nA, Prd_R, Pax_R, Prd_M, Pax_M, lRel, lErr, iPow)

Prd_E = zeros(1, nA);
Pax_E = zeros(1, nZ);

Max_Rd = 0.;
Max_Ax = 0.;
RMS_Rd = 0.;
RMS_Ax = 0.;
Pf     = 0.;

if ~lErr
    if iPow == 1
        Prd_E = Prd_R;
        Pf    = max(Prd_R);
    else
        Prd_E = Prd_M;
        Pf    = max(Prd_M);
    end
    
    return;
end
%% SET : Rad.

for ia = 1:nA
    if (Prd_M(1, ia) < 1E-9)
        continue
    end
    
    if lRel
        Prd_E(ia) = 100 * (Prd_R(ia) - Prd_M(ia)) / Prd_M(ia);
    else
        Prd_E(ia) = 100 * (Prd_R(ia) - Prd_M(ia));
    end
    
    Tmp    = Prd_E(ia);
    Max_Rd = max([Max_Rd abs(Tmp)]);
    RMS_Rd = RMS_Rd + Tmp * Tmp;
end

RMS_Rd = sqrt(RMS_Rd / nA);
%% SET : Ax.

for iz = 1:nZ
    if lRel
        Pax_E(iz) = 100 * (Pax_R(iz) - Pax_M(iz)) / Pax_M(iz);
    else
        Pax_E(iz) = 100 * (Pax_R(iz) - Pax_M(iz));
    end
    
    Tmp    = Pax_E(iz);
    Max_Ax = max([Max_Ax abs(Tmp)]);
    RMS_Ax = RMS_Ax + Tmp * Tmp;
end

RMS_Ax = sqrt(RMS_Ax / nZ);
end