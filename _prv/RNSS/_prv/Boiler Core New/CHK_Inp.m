function [F2F, nAY, nAX, nZ, nA] = CHK_Inp(F2F_R, nAY_R, nAX_R, nZ_R, nA_R, F2F_M, nAY_M, nAX_M, nZ_M)

if (nAY_R ~= nAY_M)||(nZ_R ~= nZ_M)||(abs(F2F_R - F2F_M) > 1E-5)
    error('ERROR - DIFFERENT DIMENSION');
end

nAY = nAY_M;
nZ  = nZ_M;
F2F = F2F_M;

for iy = 1:nAY_R
    if nAX_R(iy) ~= nAX_M(iy)
        error('ERROR - DIFFERENT DIMENSION');
    end
end

nAX = nAX_R;
nA  = nA_R;

end