function CONTROL_Plot(mStr, RMS, MAX, pFac, lHS, lErr, lRel)

if ~lErr
    lHS = false;
end
%% SET : Location & Size
if strcmp(mStr(1:9), 'C5G7 H FC')
    if lHS
        xStr =  35; yStr =  -40; nSze = 30;
    else
        xStr =  33; yStr =  -40; nSze = 20;
    end
elseif strcmp(mStr(1:9), 'C5G7 H EC')
    if lHS
        xStr =  95; yStr =  -90; nSze = 20;
    else
        xStr =  95; yStr = -120; nSze = 20;
    end
elseif strcmp(mStr(1:8), 'V-4.4 SC')
    if lHS
        xStr =  35; yStr =  -40; nSze = 30;
    else
        xStr =  32; yStr =  -40; nSze = 25;
    end
elseif strcmp(mStr(1:8), 'V-4.4 FC')
    if lHS
        xStr =  100; yStr =  -105; nSze = 20;
    else
        xStr =  100; yStr =  -105; nSze = 20;
    end
elseif strcmp(mStr(1:7), 'V-10 FC')
    if lHS
        xStr = 115; yStr = -120; nSze = 30;
    else
        xStr = 115; yStr = -120; nSze = 20;
    end
elseif strcmp(mStr(1:7), 'V-10 SC')
    if lHS
        xStr =  40; yStr =  -40; nSze = 30;
    else
        xStr =  36; yStr =  -40; nSze = 25;
    end
elseif strcmp(mStr(1:9), 'ABR-1T SC')
    if lHS
        xStr =  42; yStr =  -30; nSze = 20;
    else
        xStr =  35; yStr =  -40; nSze = 20;
    end
elseif strcmp(mStr(1:9), 'ABR-1T FC')
    if lHS
        xStr =  95; yStr =  -90; nSze = 20;
    else
        xStr =  80; yStr = -105; nSze = 20;
    end
end
%% PLOT : Label
xlabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
ylabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')

set(gca, 'FontSize', 30, 'FontWeight', 'bold')
%% PLOT : Remark
c = colorbar;
set(c, 'FontSize', 30);

if lErr
    str1 = sprintf('MAX : %.2f%%', MAX);
    str2 = sprintf('RMS : %.2f%%', RMS);
    
    text(xStr, yStr,{str1,str2}, 'FontWeight', 'bold', 'FontSize', nSze);
    
    if lRel
        c.Label.String = '\bf Relative Pin Power Error (%)';
    else
        c.Label.String = '\bf Absolute Pin Power Error (%)';
    end
    
    caxis([-2, 2]);
else
    str = sprintf('P.F. : %.2f%', pFac);
    
    text(xStr, yStr, str, 'FontWeight', 'bold', 'FontSize', nSze);
    
    c.Label.String = '\bf Normalized Pin Power';
    
    caxis([0, 2]);
end

axis equal
FUNC_polarmap(lErr);
end

