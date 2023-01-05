function PLOT_Core(aoF2F, nAsyCore, iSym)

if iSym == 1
    PLOT_SngCel(aoF2F);
elseif iSym == 2
    PLOT_SngAsy(aoF2F);
elseif iSym == 60
    PLOT_Core_060(aoF2F, nAsyCore);
elseif iSym == 360
    PLOT_Core_360(aoF2F, nAsyCore);
end

end

