function [xyA] = SET_AsyMap(nAY, nAX, nA)

if mod(nAY, 2) ~= 1
    error('ERROR - SET ASY MAP');
end

xyA = zeros(2, nA);
ia  = 0;
ky  = (nAY + 1) / 2;

for iy = 1:nAY
    if iy < ky
        jx = 0;
        kx = (ky + iy - 1 - nAX(iy)) / 2;
    else
        jx = iy - ky;
        kx = (nAY + ky - iy - nAX(iy)) / 2;
    end
    
    for ix = 1:nAX(iy)
        ia = ia + 1;
        
        xyA(1, ia) = ix + jx + kx;
        xyA(2, ia) = iy;
    end
end

end