function CONTROL_Plot(mStr, RMS_RAD, MAX_RAD, RMS_AX, MAX_AX, pFac, l60, lErr, lRel)

if ~lErr
    l60 = false;
end
%% SET : Location & Size
if strcmp(mStr(1:12), '3D C5G7 H FC')
    if l60
        xStr =  32; yStr =  -36; nSze = 30;
    else
        xStr =  33; yStr =  -40; nSze = 20;
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
    str1 = sprintf('RAD MAX : %.2f%%', MAX_RAD);
    str2 = sprintf('RAD RMS : %.2f%%', RMS_RAD);
    str3 = sprintf(' AX MAX : %.2f%%', MAX_AX);
    str4 = sprintf(' AX RMS : %.2f%%', RMS_AX);
    
    text(xStr, yStr,{str1, str2, str3, str4}, 'FontWeight', 'bold', 'FontSize', nSze);
    
    if lRel
        c.Label.String = '\bf Relative Pin Power Error (%)';
    else
        c.Label.String = '\bf Absolute Pin Power Error (%)';
    end
    
    caxis([-2, 2]);
else
    str = sprintf('P.F. : %.2f%', pFac);
    
    text(xStr, yStr, str, 'FontWeight', 'bold', 'FontSize', nSze);
    
    c.Label.String = '\bf Pin Power';
    
    caxis([0, 2]);
end

axis equal
FUNC_polarmap(lErr);

end