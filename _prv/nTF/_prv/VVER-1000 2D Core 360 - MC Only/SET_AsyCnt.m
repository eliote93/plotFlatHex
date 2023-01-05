function [aCnt] = SET_AsyCnt(aF2F, Pe)

% ASSUME : Symmetrically Arranged Asy
nRng = (max(Pe(4, :)) + min(Pe(4, :))) / 2;
nLen = 2 * nRng - 1;
aCnt = zeros(2, nLen, nLen);
aPch = aF2F / sqrt(3.);

dX = aF2F * 0.5;
dY = aPch * 1.5;

for iy = 1:nLen
    for ix = 1:nLen
        jx = ix - nRng;
        jy = iy - nRng;
        
        aCnt(1, ix, iy) =  dX * (jx * 2 - jy);
        aCnt(2, ix, iy) = -dY * jy;
    end
end

end