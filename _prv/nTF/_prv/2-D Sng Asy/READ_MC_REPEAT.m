function [Pm, mpRng, mPin, sdMax] = READ_MC_REPEAT(nMC, Fm)

for iMC = 1:nMC
    [tPm(:, :, iMC), mpRng, mPin, tsdMax(iMC)] = READ_MC(Fm(iMC));
end

Pm = zeros(7, mPin);

for iPin = 1:mPin
    Pm(1, iPin) = mean(tPm(1, iPin, 1:nMC));
    Pm(2:7, iPin) = tPm(2:7, iPin, 1);
end

sdMax = max(tsdMax(:)) * 100.;

fprintf('Peacking Factor : %8.5f \n', max(Pm(1, :)));
fprintf('Maximum Std. Dev. : %8.5f (percent) \n', sdMax);

end