function PLOT_RefErr(Max_R, Fin_R, Fr)

%% Storage
% A1, A2, B1, B2, C1, C2

Max_P = [117.9,   108.0,  244.1,   106.3,  477.3,   107.1];
Max_T = [  0.56,    0.10,   0.52,    0.12,   0.27,    0.10];
Fin_1 = [ 19.6,   103.5,   32.0,   103.8,   14.6,   103.0];
Fin_2 = [673.3,  1691.8,  559.8,  1588.1,  676.1,  1733.5];
Fin_3 = [324.3,   554.6,  349.9,   552.0,  315.9,   553.5];
Fin_4 = [293.1,   324.6,  297.6,   324.7,  291.5,   324.5];
%% CAL : Err.

Max_E = zeros(1, 2);
Fin_E = zeros(1, 4);

switch Fr(14:15)
    case 'A1'
        idx = 1;
    case 'A2'
        idx = 2;
    case 'B1'
        idx = 3;
    case 'B2'
        idx = 4;
    case 'C1'
        idx = 5;
    case 'C2'
        idx = 6;
end

Max_E(1) = Max_R(1) - Max_T(idx);
Max_E(2) = Max_R(2) - Max_P(idx);

Fin_E(1) = Fin_R(1) - Fin_1(idx);
Fin_E(2) = Fin_R(2) - Fin_2(idx);
Fin_E(3) = Fin_R(3) - Fin_3(idx);
Fin_E(4) = Fin_R(4) - Fin_4(idx);
%% PLOT

xStr = 2.5; yStr = Max_R(2); nSze = 15;

str1 = sprintf('vs. Reference');
str2 = sprintf('Max. Power');
str3 = sprintf('Max. Power Time');
str4 = sprintf('Final Power');
str5 = sprintf('Final Fuel Cnt. Temp.');
str6 = sprintf('Final Fuel Dop. Temp.');
str7 = sprintf('Final Cool. Out. Temp.');

text(xStr, yStr,{str1,str2,str3,str4,str5,str6,str7}, 'FontWeight', 'bold', 'FontSize', nSze);

xStr = 3.25; 

str1 = sprintf('');
str2 = sprintf(': %.2f%%',   Max_E(2));
str3 = sprintf(': %.2fsec%', Max_E(1));
str4 = sprintf(': %.2f%%',   Fin_E(1));
str5 = sprintf(': %.2f¡É%',  Fin_E(2));
str6 = sprintf(': %.2f¡É%',  Fin_E(3));
str7 = sprintf(': %.2f¡É%',  Fin_E(4));

text(xStr, yStr,{str1,str2,str3,str4,str5,str6,str7}, 'FontWeight', 'bold', 'FontSize', nSze);

end