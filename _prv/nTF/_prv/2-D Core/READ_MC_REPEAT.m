function [Pm, maRng, mpRng, mPin, maF2F, mpF2F, pFac] = READ_MC_REPEAT(nMC, Fm)

for iMC = 1:nMC
    [tPm(:, :, iMC), maRng, mpRng, mPin, tsdMax(iMC), maF2F, mpF2F] = READ_MC(Fm(iMC));
end

Pm = zeros(7, mPin);

for iPin = 1:mPin
    Pm(  1, iPin) = mean(tPm(1, iPin, 1:nMC));
    Pm(2:7, iPin) = tPm(2:7, iPin, 1);
end

sdMax = max(tsdMax(:)) * 100.;
pFac  = max(Pm(1, :));

fprintf('  Peacking Factor : %8.5f \n', pFac);
fprintf('Maximum Std. Dev. : %8.5f (percent) \n', sdMax);

end