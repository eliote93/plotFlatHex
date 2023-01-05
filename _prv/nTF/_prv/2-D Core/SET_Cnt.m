function [Cnt] = SET_Cnt(F2F, nRng, iGeo)

nLen = 2*nRng - 1;
Cnt = zeros(2, nLen, nLen);
Pch = F2F / sqrt(3.);

if iGeo == 1
    dX = F2F * 0.5;
    dY = Pch * 1.5;
    
    for iy = 1:nLen
        for ix = 1:nLen
            jx = ix - nRng;
            jy = iy - nRng;
            
            Cnt(1, ix, iy) =  dX * (jx * 2 - jy);
            Cnt(2, ix, iy) = -dY * jy;
        end
    end
else
    dX = Pch * 1.5;
    dY = F2F * 0.5;
    
    for iy = 1:nLen
        for ix = 1:nLen
            Cnt(1, ix, iy) =  dX * (ix - iy);
            Cnt(2, ix, iy) = -dY * (ix + iy - 2 * nRng);
        end
    end
end

end