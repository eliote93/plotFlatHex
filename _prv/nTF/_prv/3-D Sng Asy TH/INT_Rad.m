function [Z1, Z2, Z3, Z4] = INT_Rad(T1, T2, T3, T4, nF, nP, nZ)

Z1 = zeros(nZ, 1);
Z2 = zeros(nZ, 1);
Z3 = zeros(nZ, 1);
Z4 = zeros(nZ, 1);

for iPin = 1:nF
    iz = T1(2, iPin);
    
    Z1(iz) = Z1(iz) + T1(1, iPin);
    Z2(iz) = Z2(iz) + T2(1, iPin);
    Z3(iz) = Z3(iz) + T3(1, iPin);
end

Z1 = Z1 * nZ / nF;
Z2 = Z2 * nZ / nF;
Z3 = Z3 * nZ / nF;

for iPin = 1:nP
    iz = T4(2, iPin);
    
    Z4(iz) = Z4(iz) + T4(1, iPin);
end

Z4 = Z4 * nZ / nP;

end