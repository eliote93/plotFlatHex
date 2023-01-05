function [F2F_R, nY_R, nX_R, nZ_R, nA_R, Pr1d_R, Pax_R, PPM_R] = READ_RENUS(fid1)

%fid1 = 'C1FC.out'; % RENUS

fid = fopen(fid1);
%% READ : INP

while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 13
        continue
    end
    
    if strcmp(tline(4:11), 'rad_conf')
        Intro = textscan(tline, '%s', 100);
        Sym = sscanf(Intro{1}{2}, '%d');
    end
    
    if strcmp(tline(4:9), 'grid_x')
        Intro = textscan(tline, '%s', 100);
        nInp  = size(Intro{1}, 1);
        F2F_R = sscanf(Intro{1}{nInp}, '%f');
        
        Mgh = length(Intro{1}{nInp});
        
        for it = 1:Mgh
            if strcmp(Intro{1}{nInp}(it), '*')
                F2F_R = sscanf(Intro{1}{nInp}(it+1:Mgh), '%f');
            end
        end
    end
    
    if strcmp(tline(1:12), 'Core Average')
        break;
    end
end

if feof(fid)
    error('ERROR - READ RENUS INPUT 1');
end
%% READ : Ax

Pax_T = zeros(1, 100);
nZ_R  = 0;

while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh == 0
        break;
    end
    
    nZ_R = nZ_R + 1;
    
    Intro = textscan(tline, '%s', 100);
    Pax_T(1, nZ_R) = sscanf(Intro{1}{2}, '%f');
end

if feof(fid)
    error('ERROR - READ RENUS INPUT 2');
end
%% READ : Rad

fgetl(fid);

Pr1d_T = zeros(1, 1000);
nX_T  = zeros(1,  100); % # of Column
nA_R  = 0;
nY_R  = 0;

while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh == 0
        break;
    end
    
    Intro = textscan(tline, '%s', 100);
    nx    = size(Intro{1}, 1);
    
    for ix = 1:nx
        Tmp(ix) = sscanf(Intro{1}{ix}, '%f');
    end
    
    if sum(Tmp(1:nx)) < 1E-5
        continue;
    end
    
    nY_R = nY_R + 1;
    
    for ix = 1:nx
        if Tmp(ix) > 1E-5
            nA_R = nA_R + 1;
            
            Pr1d_T(1, nA_R) = Tmp(ix);
            nX_T  (1, nY_R) = nX_T(1, nY_R) + 1;
        end
    end
end

if feof(fid)
    error('ERROR - READ RENUS INPUT 3');
end
%% EXPAND : sym

Pax_R(1:nZ_R) = Pax_T(1:nZ_R);

if Sym == 360
    Pr1d_R(1:nA_R) = Pr1d_T(1:nA_R);
    nX_R  (1:nY_R) = nX_T (1:nY_R);
elseif Sym == 180
    [Pr1d_R, nX_R, nA_R, nY_R] = EXPAND_Power_H2F(Pr1d_T, nX_T, nA_R, nY_R);
else
    [Pr1d_T, nX_T, nA_R]       = EXPAND_Power_Q2H(Pr1d_T, nX_T, nA_R, nY_R);
    [Pr1d_R, nX_R, nA_R, nY_R] = EXPAND_Power_H2F(Pr1d_T, nX_T, nA_R, nY_R);
end
%% READ : PPM

while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 15
        continue
    end
    
   if strcmp(tline(11:15), 'BORON')
       Intro = textscan(tline, '%s', 100);
       PPM_R = sscanf(Intro{1}{3}, '%f');
       
       break
   end
end

if feof(fid)
    error('ERROR - READ RENUS INPUT 4');
end

fclose(fid);
end