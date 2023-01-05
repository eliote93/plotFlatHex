function [Prd_E, Pax_E, Max_Rd, Max_Ax, RMS_Rd, RMS_Ax, Pf] = SET_PowErr(nA, nZ, Prd_R, Pax_R, Prd_M, Pax_M, lRel, lErr)

Prd_E = zeros(1, nA);
Pax_E = zeros(1, nZ);

Max_Rd = 0.;
Max_Ax = 0.;
RMS_Rd = 0.;
RMS_Ax = 0.;

Pf = max(Prd_M);

if ~lErr
    Prd_E(1:nA) = Prd_M(1:nA);
    
    return
end
%% SET : Rad. Err
for ia = 1:nA
    if lRel
        Prd_E(1, ia) = 100 * (Prd_R(1, ia) - Prd_M(1, ia)) / Prd_M(1, ia);
    else
        Prd_E(1, ia) = 100 * (Prd_R(1, ia) - Prd_M(1, ia));
    end
    
    Tmp    = Prd_E(1, ia);
    Max_Rd = max([Max_Rd abs(Tmp)]);
    RMS_Rd = RMS_Rd + Tmp * Tmp;
end

RMS_Rd = sqrt(RMS_Rd / nA);
%% SET : Ax. eRR
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

RMS_Ax = sqrt(RMS_Ax / nZ); %% Not Exact !!
end