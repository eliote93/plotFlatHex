function PLOT_MasErr(nTot_R, Tot_R, Tot_M, Tot_E, Max_E, Fin_E, lMas)

hold on

xlabel('Time, sec', 'FontSize', 30, 'FontWeight', 'bold')
set(gca, 'FontSize', 30, 'FontWeight', 'bold')

yyaxis left
ylabel('Power, % of 2775 MW', 'FontSize', 30, 'FontWeight', 'bold')

if lMas
    plot(Tot_M(1, 1:nTot_R), Tot_M(2, 1:nTot_R), 'LineWidth', 2)
else
    plot(Tot_R(1, 1:nTot_R), Tot_R(2, 1:nTot_R), 'LineWidth', 2)
    
    return
end

yyaxis right
ylabel('Power Err. %', 'FontSize', 30, 'FontWeight', 'bold')
plot(Tot_E(1, 1:nTot_R), Tot_E(2, 1:nTot_R), 'LineWidth', 2)

yyaxis left
xStr = 3.75; yStr = Max_R(2); nSze = 15;

str1 = sprintf('vs. MASTER');
str2 = sprintf('Max. Power');
str3 = sprintf('Max. Power Time');
str4 = sprintf('Final Power');
str5 = sprintf('Final Fuel Cnt. Temp.');
str6 = sprintf('Final Fuel Dop. Temp.');
str7 = sprintf('Final Cool. Out. Temp.');

text(xStr, yStr,{str1,str2,str3,str4,str5,str6,str7}, 'FontWeight', 'bold', 'FontSize', nSze);

xStr = 4.5; 

str1 = sprintf('');
str2 = sprintf(': %.2f%%',   Max_E(2));
str3 = sprintf(': %.2fsec%', Max_E(1));
str4 = sprintf(': %.2f%%',   Fin_E(1));
str5 = sprintf(': %.2f¡É%',  Fin_E(2));
str6 = sprintf(': %.2f¡É%',  Fin_E(3));
str7 = sprintf(': %.2f¡É%',  Fin_E(4));

text(xStr, yStr,{str1,str2,str3,str4,str5,str6,str7}, 'FontWeight', 'bold', 'FontSize', nSze);

end