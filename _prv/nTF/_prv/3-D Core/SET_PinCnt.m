function [pCnt] = SET_PinCnt(pF2F, nRng)

% ASSUME : Symmetrically Arranged Pin
nLen = 2*nRng - 1;
pCnt = zeros(2, nLen, nLen);
pPch = pF2F / sqrt(3.);

dX = pPch * 1.5;
dY = pF2F * 0.5;

for iy = 1:nLen
    for ix = 1:nLen
        pCnt(1, ix, iy) =  dX * (ix - iy);
        pCnt(2, ix, iy) = -dY * (ix + iy - 2 * nRng);
    end
end

end