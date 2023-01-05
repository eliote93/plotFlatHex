function [Pn] = CHK_Inp(maRng, naRng, mpRng, npRng, maF2F, naF2F, mpF2F, npF2F, lHS, nPin, Pn, lErr)

if ~lErr
    return
end

Eps = 1E-5;

if maRng ~= naRng || mpRng ~= npRng
    error('DIFFERENT DIMENSION');
end

if abs(maF2F - naF2F) > Eps || abs(mpF2F - npF2F) > Eps
    error('DIFFERENT DIMENSION');
end

if lHS
    for iPin = 1:nPin
        Pn(3, iPin) = Pn(3, iPin) + maRng - 1;
        Pn(4, iPin) = Pn(4, iPin) + maRng - 1;
    end
end

end