function [Pn] = MODIFY_aIdx360(nAsy, mAsy, nPin, Pn)

for nAsyRng = 1:100
    if 3*nAsyRng*(nAsyRng-1) + 1 == mAsy
        break;
    end
end

if nAsy ~= nAsyRng*(nAsyRng+1)/2
    error('DIFFERENT DIMENSION');
end

aIdx360 = zeros(1, nAsy);
jAsy    = 0;
aIdxSt  = (mAsy + 1)/2;

for iy = 1:nAsyRng
    for ix = 1:nAsyRng+1-iy
        jAsy = jAsy + 1;
        
        aIdx360(jAsy) = aIdxSt + ix - 1;
    end
    
    aIdxSt = aIdxSt + 2*nAsyRng - iy;
end

for iPin = 1:nPin
    Pn(3, iPin) = aIdx360(Pn(3, iPin));
end

end

