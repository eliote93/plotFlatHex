function CONTROL_Plot(Max_Rd, RMS_Rd, Max_Ax, RMS_Ax, Pf, lRel, lErr)

str1 = sprintf('RAD MAX : %.2f%%', Max_Rd);
str2 = sprintf('RAD RMS : %.2f%%', RMS_Rd);
str3 = sprintf(' AX MAX : %.2f%%', Max_Ax);
str4 = sprintf(' AX RMS : %.2f%%', RMS_Ax);
str5 = sprintf('P.F. : %.2f%',     Pf);

if lErr
    text(53.5,-53,{str1, str2, str3, str4}, 'FontWeight', 'bold', 'FontSize', 15);
else
    text(53.5,-53,{str5}, 'FontWeight', 'bold', 'FontSize', 25);
end

xlabel('cm', 'FontSize', 30, 'FontWeight', 'bold')
ylabel('cm', 'FontSize', 30, 'FontWeight', 'bold')
set(gca, 'FontSize', 30, 'FontWeight', 'bold')

xlim([-70 70]);
ylim([-70 70]);

c = colorbar;
if lErr
    if lRel
        c.Label.String = '\bf Relative Assembly Power Error (%)';
    else
        c.Label.String = '\bf Absolute Assembly Power Error (%)';
    end
else
    c.Label.String = '\bf Normalized Assembly Power';
end
set(c, 'FontSize', 30);
caxis([-2, 2]);

axis equal
FUNC_polarmap(lErr);

end