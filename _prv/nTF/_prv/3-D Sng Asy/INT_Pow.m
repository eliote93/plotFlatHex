function [Pn_RAD, Pn_AX, nR, nZ] = INT_Pow(Pn, nPin)

nZ  = max(Pn(2, :)) - min(Pn(2, :)) + 1;

if mod(nPin, nZ) ~= 0
    error('NOT AXIALLY SYMMETRIC POWER');
end

nR = nPin / nZ;
Pn_RAD = zeros(7, nR); % iz = 1
Pn_AX  = zeros(nZ);

Pn_RAD(2, :) = 1;
Pn_RAD(3:7, 1:nR) = Pn(3:7, 1:nR);

for iPin = 1:nR
    for iz = 1:nZ
        Pn_RAD(1, iPin) = Pn_RAD(1, iPin) + Pn(1, iPin + nR * (iz - 1));
    end
    
    Pn_RAD(1, iPin) = Pn_RAD(1, iPin) / nZ;
end

for iz = 1:nZ
    izst = nR * (iz-1) + 1;
    ized = nR * iz;
    Pn_AX(iz) = sum(Pn(1, izst:ized)) / nR;
end

end