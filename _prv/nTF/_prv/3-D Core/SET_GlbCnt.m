function [mCnt, lBndy] = SET_GlbCnt(Pm, mPin, aCnt, pCnt, nFld, lROT)

if nFld == 1
    mCnt = zeros(2, 1, mPin);
else
    mCnt = zeros(2, 6, mPin);
end

for iPin = 1:mPin
    iax = Pm(3, iPin);
    iay = Pm(4, iPin);
    ipx = Pm(6, iPin);
    ipy = Pm(7, iPin);
    
    mCnt(1:2, 1, iPin) = aCnt(1:2, iax, iay) + pCnt(1:2, ipx, ipy);
end

lBndy = boolean(zeros(1, mPin));

if nFld == 1
    return
end

Sq3 = sqrt(3.);

if lROT
    for iPin = 1:mPin
        if abs(mCnt(2, 1, iPin)) < 1E-6 || abs(mCnt(1, 1, iPin) * Sq3 + mCnt(2, 1, iPin)) < 1E-6
            lBndy(iPin) = true;
        end
        
        for iFld = 2:6
            [mCnt(1:2, iFld, iPin)] = ROT_Pt(mCnt(1:2, iFld-1, iPin), pi / 3.);
        end
    end
else
    for iPin = 1:mPin
        if abs(mCnt(2, 1, iPin)) < 1E-6 || abs(mCnt(1, 1, iPin) * Sq3 + mCnt(2, 1, iPin)) < 1E-6
            lBndy(iPin) = true;
            
            for iFld = 2:6
                [mCnt(1:2, iFld, iPin)] = ROT_Pt(mCnt(1:2, iFld-1, iPin), pi / 3.);
            end
            
            continue
        end
        
        for iFld = 2:6
            [mCnt(1:2, iFld, iPin)] = REF_Pt(mCnt(1:2, iFld-1, iPin), (iFld - 2) * pi / 3.);
        end
    end
end

end