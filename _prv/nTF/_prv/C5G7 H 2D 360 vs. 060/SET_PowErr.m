function [Pe, RMS, MAX] = SET_PowErr(Pm, mPin, Pn, nPin)

Pe   = zeros(4, nPin);
RMS  = 0.;
MAX  = 0.;
kPin = 0;

Kn = zeros(1, nPin);
KK = 0.;

for iPin = 1:nPin
    if Pn(4, iPin) < 1E-7
        continue;
    end
    
    for jPin = 1:mPin
        if Pm(1, jPin) == Pn(1, iPin) && Pm(2, jPin) == Pn(2, iPin) && Pm(3, jPin) == Pn(3, iPin)
            Kn(iPin) = jPin;
            KK = KK + Pm(4, jPin);
            break;
        end
    end
    
    if Kn(iPin) == 0
        error('NO CORRESPONDING MC PIN');
    end
end

KK = KK / nPin;

for iPin = 1:nPin
    jPin = Kn(iPin);
    Pk   = Pm(4, jPin) / KK;
    
    DEL  = 100 * (Pn(4, iPin) - Pk) / Pk;
    RMS  = RMS + DEL * DEL;
    MAX  = max([MAX abs(DEL)]);
    kPin = kPin + 1;
    
    Pe(1, iPin) = Pn(1, iPin);
    Pe(2, iPin) = Pn(2, iPin);
    Pe(3, iPin) = Pn(3, iPin);
    Pe(4, iPin) = DEL;
end

RMS = sqrt(RMS / kPin);

end

