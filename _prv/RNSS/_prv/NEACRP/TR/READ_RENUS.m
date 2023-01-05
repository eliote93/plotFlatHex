function [nTot_R, Tot_R, Max_R, Fin_R] = READ_RENUS(Fr)
% # of time steps
% Time step, Total power
% Time for Max. power, Max. power
% Final : power, fuel cnt. temp., fuel doppler temp., coolant out temp.

%fid1 = 'RENUS_NEACRP_A1_QC.plt'; % RENUS

fid = fopen(Fr);
%% READ : Power Change

Ptot_T = zeros(1, 10000);
Tsec_T = zeros(1, 10000);
Max_R  = zeros(1, 2);
Fin_R  = zeros(1, 4);
nTot_R = 0;

fgetl(fid);

while (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 5
        break
    end
    
    nTot_R = nTot_R + 1;
    
    Intro = textscan(tline, '%s', 100);
    
    Tsec_T(nTot_R) = sscanf(Intro{1}{1}, '%f');
    Ptot_T(nTot_R) = sscanf(Intro{1}{2}, '%f');
    
    Fin_R(2) = sscanf(Intro{1}{3}, '%f'); % Final Fuel Cnt. Temp.
    Fin_R(3) = sscanf(Intro{1}{4}, '%f'); % Final Fuel Doppler Temp.
    Fin_R(4) = sscanf(Intro{1}{5}, '%f'); % Final Coolant Outlet Temp.
    
    if Ptot_T(nTot_R) > Max_R(2)
        Max_R(2) = Ptot_T(nTot_R);
        Max_R(1) = Tsec_T(nTot_R);
    end
end
%% CP : Power

Tot_R = zeros(2, nTot_R);

Tot_R(1, 1:nTot_R) = Tsec_T(1:nTot_R);
Tot_R(2, 1:nTot_R) = Ptot_T(1:nTot_R);

Fin_R(1) = Tot_R(2, nTot_R); % Final Power

fclose(fid);
end