function [Pe, RMS, MAX] = SET_PowErr(Pm, Pn, nPin, mPin, lRel, lErr)

Pe  = zeros(7, nPin);
RMS = 0.;
MAX = 0.;
Idx = 0;

if ~lErr
    Pe(1:7, 1:mPin) = Pm(1:7, 1:mPin);
end

for iPin = 1:nPin
    for jPin = 1:mPin
        if Pn(2, iPin) == Pm(2, jPin) % iz
            if Pn(3, iPin) == Pm(3, jPin) && Pn(4, iPin) == Pm(4, jPin) % iax, iay
                if Pn(6, iPin) == Pm(6, jPin) && Pn(7, iPin) == Pm(7, jPin) % ipx, ipy
                    Idx = iPin;
                    break
                end
            end
        end
    end
    
    if Idx ~= iPin
        error("DIFFERENT INDEX");
    end
    
    if lRel
        DEL = 100 * (Pn(1, iPin) - Pm(1, jPin)) / Pm(1, iPin);
    else
        DEL = 100 * (Pn(1, iPin) - Pm(1, jPin));
    end
    
    RMS = RMS + DEL * DEL;
    MAX = max([MAX, abs(DEL)]);
    
    Pe(1, iPin) = DEL;
    Pe(2:7, iPin) = Pn(2:7, iPin);
end

RMS = sqrt(RMS / nPin);

end