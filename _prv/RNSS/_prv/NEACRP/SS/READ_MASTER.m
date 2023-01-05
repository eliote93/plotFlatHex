function [F2F_M, nY_M, nX_M, nZ_M, nA_M, Pr1d_M, Pax_M, PPM_M] = READ_MASTER(fid2)

%fid2 = 'NEACRP_C1_FC_sS.out'; % MASTER

fid  = fopen(fid2);
%% READ : INP

while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 9
        continue
    end
    
    if strcmp(tline(2:9), '%GEN_GEO')
        tline = fgetl(fid);
        Intro = textscan(tline, '%s', 100);
        F2F_M = sscanf(Intro{1}{1}, '%f');
    end
    
    if strcmp(tline(2:9), '%GEN_DIM')
        fgetl(fid);
        tline = fgetl(fid);
        Intro = textscan(tline, '%s', 100);
        Sym   = sscanf(Intro{1}{2}, '%f');
    end
    
    if strcmp(tline(2:6), 'BORON')
        Intro = textscan(tline, '%s', 100);
        PPM_M = sscanf(Intro{1}{4}, '%f');
    end
    
    if ~strcmp(tline(1), '1')
        continue
    end
    
    tline = fgetl(fid);
    
    if strcmp(tline(24:39), 'AXIALLY AVERAGED')
        break
    end
end

if feof(fid)
    error('ERROR - READ MASTER INPUT 1');
end
%% READ : Rad

Pr1d_T = zeros(1, 1000);
nAX_T  = zeros(1, 100);
nY_M   = 0;
nA_M   = 0;

for i = 1: 15
    fgetl(fid);
end

while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 5
        break
    end
    
    nY_M  = nY_M + 1; %% ASSUME : Non-Zero Row
    Intro = textscan(tline, '%s', 100);
    nx    = size(Intro{1}, 1);
    
    nAX_T(1, nY_M) = nx - 1;
    
    for ix = 2:nx
        nA_M = nA_M + 1;
        
        Pr1d_T(1, nA_M) = sscanf(Intro{1}{ix}, '%f');
    end
    
    fgetl(fid);
end

if feof(fid)
    error('ERROR - READ MASTER INPUT 2');
end
%% READ : Ax

Pax_T = zeros(1, 100);
nZ_M  = 0;

while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 5
        continue
    end
    
    if ~strcmp(tline(1), '1')
        continue
    end
    
    tline = fgetl(fid);

    if strcmp(tline(24:37), 'LAYER AVERAGED')
        break
    end
end

if feof(fid)
    error('ERROR - READ MASTER INPUT 3');
end

for i = 1: 12
    fgetl(fid);
end

while  (~feof(fid))
    tline = fgetl(fid);
    Intro = textscan(tline, '%s', 100);
    Lgh   = size(Intro{1});
    
    if Lgh < 2
        break;
    end
    
    nZ_M = nZ_M + 1;
    
    Pax_T(1, nZ_M) = sscanf(Intro{1}{3}, '%f');
end
%% EXPAND : sym

Pax_M = zeros(1, nZ_M);

for iz = 1:nZ_M
    Pax_M(iz) = Pax_T(nZ_M - iz + 1);
end

if Sym == 1 % Full-core
   nX_M(1:nY_M) = nAX_T(1:nY_M);
   Pr1d_M(1:nA_M)  = Pr1d_T(1:nA_M); 
else
   error('UNDER-CONSTRUCTION'); 
end

fclose(fid);
end