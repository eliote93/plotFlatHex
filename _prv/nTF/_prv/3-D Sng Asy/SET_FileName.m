function [Fm, Fn] = SET_FileName(mStr, nStr, nMC)

Fm = strings(1, nMC);

for iMC = 1:nMC
    if iMC < 10
        sInt = strcat("0", int2str(iMC));
    else
        sInt = sprintf('%2d', iMC);
    end
    
    Fm(iMC) = strcat("MC ", mStr, " ", sInt);
end

Fn = strcat("nTF ", nStr, ".out");

end