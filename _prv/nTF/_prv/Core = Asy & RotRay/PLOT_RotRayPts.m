function PLOT_RotRayPts(Fn, aoF2F, nAsyCore, iSym, iAng, a)

iRot = 1; % Rot Ray Idx

if iSym == 1 || iSym == 2
    PLOT_RotRayPts_Sng(Fn, iRot);
elseif iSym == 60
    if a == "VAC"
        PLOT_RotRayPts_060_VAC(Fn, iAng);
    elseif a == "REF"
        PLOT_RotRayPts_060_REF(Fn, iRot, aoF2F, nAsyCore);
    elseif a == "ROT"
        PLOT_RotRayPts_060_ROT(Fn, iAng);
    end
elseif iSym == 360
    PLOT_RotRayPts_360(Fn, iAng);
end

end

