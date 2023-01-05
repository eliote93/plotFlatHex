function [xyA] = SET_xyA(nAY, nAX, nA)
% ASSUME : 360

if mod(nAY, 2) ~= 1
    error('ERROR - SET XYA 1');
end

xyA = zeros(2, nA);
mA  = 0;
ky  = (nAY + 1) / 2;

for iy = 1:nAY
    if mod(nAX(iy), 2) ~= 1
        error('ERROR - SET XYA 2');
    end
    
    kx = (nAX(iy) + 1) / 2;
    
    for ix = 1:nAX(iy)
        mA = mA + 1;
        
        xyA(1, mA) = ix - kx;
        xyA(2, mA) = ky - iy;
    end
end

end