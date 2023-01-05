function [nTot_M, Tot_M, Max_M, Fin_M] = READ_MASTER(Fm, lMas)
% # of time steps
% Time step, Total power
% Time for Max. power, Max. power
% Final : power, fuel cnt. temp., fuel doppler temp., coolant out temp.

%Fm = 'MASTER_NEACRP_A1_HC.sum'; % MASTER

nTot_M = 0;
Tot_M  = 0;
Max_M  = zeros(1, 2);
Fin_M  = zeros(1, 4);

if ~lMas
    return
end

fid = fopen(Fm);
%% READ : INP

while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 30
        continue
    end
    
    if strcmp(tline(21:30), 'REACTIVITY')
        break
    end
end

if feof(fid)
    error('ERROR - READ MASTER INPUT 1');
end
%% READ : Power Change

Ptot_T = zeros(1, 10000);
Tsec_T = zeros(1, 10000);

for i = 1:4
    fgetl(fid);
end

while (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 5
        break
    end
    
    nTot_M = nTot_M + 1;
    
    Intro = textscan(tline, '%s', 100);
    
    Tsec_T(nTot_M) = sscanf(Intro{1}{2}, '%f');
    Ptot_T(nTot_M) = sscanf(Intro{1}{6}, '%f');
    
    if Ptot_T(nTot_M) > Max_M(2)
        Max_M(1) = Tsec_T(nTot_M);
        Max_M(2) = Ptot_T(nTot_M);
    end
end

if feof(fid)
    error('ERROR - READ MASTER INPUT 2');
end
%% CP : Power

Tot_M = zeros(2, nTot_M);

Tot_M(1, 1:nTot_M) = Tsec_T(1:nTot_M);
Tot_M(2, 1:nTot_M) = Ptot_T(1:nTot_M);

Fin_M(1) = Tot_M(2, nTot_M); % Final Power
%% READ : T/H

while (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 44
        continue
    end
    
    if strcmp(tline(21:27), 'THERMAL')
        break
    end
end

if feof(fid)
    error('ERROR - READ MASTER INPUT 3');
end

for i = 1:4
    fgetl(fid);
end

while (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 5
        break
    end
    
    Intro = textscan(tline, '%s', 100);
    
    Fin_M(2) = sscanf(Intro{1}{5}, '%f'); % Final Fuel Cnt. Temp.
    Fin_M(3) = sscanf(Intro{1}{4}, '%f'); % Final Fuel Doppler Temp.
    Fin_M(4) = sscanf(Intro{1}{7}, '%f'); % Final Coolant Outlet Temp.
end

fclose(fid);
end