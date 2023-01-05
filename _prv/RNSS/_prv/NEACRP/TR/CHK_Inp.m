function CHK_Inp(nTot_R, Tot_R, nTot_M, Tot_M, lMas)

if ~lMas
    return
end

if (nTot_R ~= nTot_M)
    error('ERROR - DIFFERENT TIME STEP 1');
end

for it = 1:nTot_R
    if Tot_R(1, it) ~= Tot_M(1, it)
        error('ERROR - DIFFERENT TIME STEP 2');
    end
end

end