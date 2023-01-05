function [aCnt] = SET_AsyCnt(aF2F, nAsy)

for naRng = 1:100
    Tmp = 3 * naRng * (naRng - 1) + 1;
    
    if Tmp == nAsy
        break;
    end
end

if naRng == 100
    error('WRONG # OF ASY');
end

nLen = 2*naRng - 1;
aCnt = zeros(2, nAsy);
aPch = aF2F / sqrt(3.);

dx = aF2F * 0.5;
dy = aPch * 1.5;

xSt  = -0.5 * aF2F * (naRng - 1);
ySt  =  1.5 * aPch * (naRng - 1);
ex   = naRng;
sx   = 1;
iAsy = 0;
%% Top
for iy = 1:naRng-1
    x = xSt;
    y = ySt;
    
    for ix = 1:ex
        iAsy = iAsy + 1;
        
        aCnt(1, iAsy) = x;
        aCnt(2, iAsy) = y;
        
        x = x + aF2F;
    end
    
    xSt = xSt - dx;
    ySt = ySt - dy;
    ex  = ex + 1;
end
%% Bottom
for iy = naRng:nLen
    x = xSt;
    y = ySt;
    
    for ix = sx:ex
        iAsy = iAsy + 1;
        
        aCnt(1, iAsy) = x;
        aCnt(2, iAsy) = y;
        
        x = x + aF2F;
    end
    
    xSt = xSt + dx;
    ySt = ySt - dy;
    sx  = sx + 1;
end

end

