function [F2F_R, nAY_R, nAX_R, nZ_R, nA_R, Prd_R, Pax_R] = READ_RENUS(fid1)

%fid1 = 'BOILER_CORE_0ppm_HZP_nTSTL_ARO.out'; % RENUS

fid = fopen(fid1);

%% READ : Basic
while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 11
        continue
    end
    
    if strcmp(tline(4:11), 'grid_hex')
        Intro = textscan(tline, '%s', 100);
        F2F_R = sscanf(Intro{1}{2}, '%f');
    end
    
    if strcmp(tline(4:11), 'rad_conf')
        Intro = textscan(tline, '%s', 100);
        Sym = sscanf(Intro{1}{2}, '%d');
    end
    
    if strcmp(tline(2:9), 'Assembly')
        break;
    end
end

if (feof(fid))
    error('ERROR - READ RENUS 1');
end
%% READ : Rad.
fgetl(fid);fgetl(fid);fgetl(fid);

nA_R  = 0;
nAY_R = 0;
Prd_T = zeros(1, 10000);
nAX_T = zeros(1, 100);

while (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 5
        break
    end
    
    nAY_R = nAY_R + 1;
    
    Intro = textscan(tline, '%s', 500);
    nx    = size(Intro{1}, 1);
    
    nAX_T(nAY_R) = nx - 1;
    
    for ix = 2:nx
        nA_R = nA_R + 1;
        
        Prd_T(nA_R) = sscanf(Intro{1}{ix}, '%f');
    end
end

if (feof(fid))
    error('ERROR - READ RENUS 2');
end
%% READ : Ax.
for i = 1:5
    tline = fgetl(fid);
end

nZ_R  = 0;
Pax_T = zeros(1, 100);

while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 5
        break
    end
    
    nZ_R = nZ_R + 1;
    
    Intro = textscan(tline, '%s', 100);
    Pax_T(nZ_R) = sscanf(Intro{1}{2}, '%f');
end

if (feof(fid))
    error('ERROR - READ RENUS 3');
end
%% EXAPND : Sym

Pax_R(1:nZ_R) = Pax_T(1:nZ_R);

if Sym == 360
   nAX_R(1:nAY_R) = nAX_T(1:nAY_R);
   Prd_R(1:nA_R)  = Prd_T(1:nA_R); 
else
   error('UNDER-CONSTRUCTION- READ RENUS'); 
end

fclose(fid);
end