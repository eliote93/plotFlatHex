function [pCnt] = SET_PinCnt(pF2F, npRng)

nLen = 2*npRng - 1;
pCnt = zeros(2, nLen, nLen);
pPch = pF2F / sqrt(3.);

dx = pPch * 1.5;
dy = pF2F * 0.5;

xSt = 0.;
ySt = pF2F * (npRng - 1);
ex  = npRng;
sx  = 1;
%% Top
for iy = 1:npRng-1
    x = xSt;
    y = ySt;
    
    for ix = 1:ex
        pCnt(1, ix, iy) = x;
        pCnt(2, ix, iy) = y;
        
        x = x + dx;
        y = y - dy;
    end
    
    xSt = xSt - dx;
    ySt = ySt - dy;
    ex  = ex + 1;
end
%% Bottom
for iy = npRng:nLen
    x = xSt;
    y = ySt;
    
    for ix = sx:ex
        pCnt(1, ix, iy) = x;
        pCnt(2, ix, iy) = y;
        
        x = x + dx;
        y = y - dy;
    end
    
    ySt = ySt - pF2F;
    sx  = sx + 1;
end

end

