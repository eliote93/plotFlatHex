function [F2F_M, nAY_M, nAX_M, nZ_M, nA_M, Prd_M, Pax_M, k_M] = READ_MASTER(fid2)

% fid2 = 'MASTER_BOILER_CORE_0ppm_HZP_ARO.out'; % RENUS
% F2F  = Flat-to-Flat [cm]
% nAY  = # of y-nodes
% nAX  = # of x-nodes per y-nodes
% nAZ  = # of Z-nodes
% nA   = # of Asy.
% Prd  = Radial Power (Normalized)
% Pax  = Axial Power (Normalized)
% k    = k-eff value

fid = fopen(fid2);
%% READ : Basic
while ~feof(fid)
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 8
        continue
    end
    
    if strcmp(tline(1:8), '%GEN_GEO')
        tline = fgetl(fid);
        Intro = textscan(tline, '%s', 100);
        F2F_M = sscanf(Intro{1}{1}, '%f') * sqrt(3.);
    end
    
    if strcmp(tline(1:8), '%GEN_DIM')
        tline = fgetl(fid);
        tline = fgetl(fid);
        Intro = textscan(tline, '%s', 100);
        Sym   = sscanf(Intro{1}{2}, '%d');
    end
    
    if strcmp(tline(1:8), '%EXE_STD')
       tline = fgetl(fid);
       Intro = textscan(tline, '%s', 100);
       cfsp  = sscanf(Intro{1}{1}, '%s');
       lfsp  = strcmp(cfsp, 'extso');
    end
    
    if Lgh > 64
        if strcmp(tline(11:65), 'AXIALLY AVERAGED MAXIMUM PIN AND FA POWER DISTRIBUTIONS')
            break
        end
    end
end

if feof(fid)
    error('ERROR - READ MASTER 1');
end
%% READ : Rad.
for i = 1:9
    fgetl(fid);
end

tline = fgetl(fid);
Intro = textscan(tline, '%s', 100);

if ~lfsp
    k_M = sscanf(Intro{1}{3}, '%f');
else
    k_M = 0.;
end

for i = 1:4
    fgetl(fid);
end

nA_M  = 0;
nAY_M = 0;
Prd_T = zeros(1, 10000);
nAX_T = zeros(1, 100);

while ~feof(fid)
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 5
        break
    end
    
    nAY_M = nAY_M + 1;
    
    Intro = textscan(tline, '%s', 500);
    nx    = size(Intro{1}, 1);
    
    nAX_T(nAY_M) = nx - 1;
    
    for ix = 2:nx
        nA_M = nA_M + 1;
        
        Prd_T(nA_M) = sscanf(Intro{1}{ix}, '%f');
    end
    
    for i = 1:3
        fgetl(fid);
    end
end

if feof(fid)
    error('ERROR - READ MASTER 2');
end
%% READ : Ax.

while ~feof(fid)
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh > 32
        if strcmp(tline(11:33), '1-D POWER DISTRIBUTIONS')
            break
        end
    end
end

if feof(fid)
    error('ERROR - READ MASTER 3');
end

for i = 1: 8
    fgetl(fid);
end

nZ_M  = 0;
Pax_T = zeros(1, 100);

while  ~feof(fid)
    tline = fgetl(fid);
    
    if strcmp(tline(11), '-')
        break
    end
    
    nZ_M = nZ_M + 1;
    
    Intro = textscan(tline, '%s', 100);
    Pax_T(nZ_M) = sscanf(Intro{1}{3}, '%f');
end

if feof(fid)
    error('ERROR - READ MASTER 4');
end
%% EXAPND : Sym

Pax_M = zeros(1, nZ_M);

for iz = 1:nZ_M
    Pax_M(iz) = Pax_T(nZ_M - iz + 1);
end

if Sym == 1
   nAX_M(1:nAY_M) = nAX_T(1:nAY_M);
   Prd_M(1:nA_M)  = Prd_T(1:nA_M); 
else
    error('UNDER-CONSTRUCTION - READ MASTER');
end

fclose(fid);
end