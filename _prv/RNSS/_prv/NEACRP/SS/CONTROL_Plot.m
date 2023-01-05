function CONTROL_Plot(Max_Rd, RMS_Rd, Max_Ax, RMS_Ax, F2F, nAY, Pf, lRel, lErr, PPM_E)

str1 = sprintf('RAD MAX : %.2f%%', Max_Rd);
str2 = sprintf('RAD RMS : %.2f%%', RMS_Rd);
str3 = sprintf('   AX MAX : %.2f%%', Max_Ax);
str4 = sprintf('   AX RMS : %.2f%%', RMS_Ax);
str5 = sprintf('P.F. : %.2f%',     Pf);
str6 = sprintf('       dPPM : %.1fppm%', PPM_E);

if lErr
    text(105,-130,{str1, str2, str3, str4, str6}, 'FontWeight', 'bold', 'FontSize', 15);
else
    text(105,-130,{str5}, 'FontWeight', 'bold', 'FontSize', 20);
end

xlabel('cm', 'FontSize', 30, 'FontWeight', 'bold')
ylabel('cm', 'FontSize', 30, 'FontWeight', 'bold')
set(gca, 'FontSize', 30, 'FontWeight', 'bold')

kY = (nAY + 1) / 2;

xlim([-kY * F2F kY * F2F]);
ylim([-kY * F2F kY * F2F]);

c = colorbar;
if ~lErr
    c.Label.String = '\bf Normalized Assembly Power';
    
    caxis([0, 2]);
else
    if lRel
        c.Label.String = '\bf Relative Assembly Power Error (%)';
    else
        c.Label.String = '\bf Absolute Assembly Power Error (%)';
    end
    
    caxis([-2, 2]);
end
set(c, 'FontSize', 30);

axis equal
FUNC_polarmap(lErr);

end