function [Pz, Lz, Sd, nD, nZ, sX, sY] = READ_Data(Fn)

fid = fopen(Fn);
%% READ : Dimension
tline = fgetl(fid);
Lgh   = length(tline);

nZ = sscanf(tline(12:Lgh), '%d');

tline = fgetl(fid);
Lgh   = length(tline);

nD = sscanf(tline(12:Lgh), '%d');

tline = fgetl(fid);
Intro = textscan(tline, '%s', 100);

if length(Intro{1}) < nD + 2
    error("ERROR : DATA NAME");
end

Sd = strings(1, nD);

for id = 1:nD
    Sd(id) = sscanf(Intro{1}{id+2}, '%s');
end

tline = fgetl(fid);
Lgh   = length(tline);

sX = tline(12:Lgh);

tline = fgetl(fid);
Lgh   = length(tline);

sY = tline(12:Lgh);

tline = fgetl(fid);
Intro = textscan(tline, '%s', 100);
Sze   = length(Intro{1}) - 1;
iz    = 0;
Lz    = zeros(1, nZ+1);

for is = 1:Sze
    tline = sscanf(Intro{1}{is+1}, '%s');
    Lgh   = length(tline);
    
    for ic = 1:Lgh
        if tline(ic) == "*"
            break;
        end
    end
    
    if ic < Lgh
        nC  = sscanf(tline(1:ic-1),   '%d');
        Val = sscanf(tline(ic+1:Lgh), '%f');
        
        Lz(iz+1:iz+nC) = Val;
        
        iz = iz + nC;
    else
        iz = iz + 1;
        
        Lz(iz) = sscanf(tline, '%f');
    end
end

if iz ~= nZ
    error("ERROR : LZ");
end

for iz = 2:nZ
    Lz(iz) = Lz(iz-1) + Lz(iz);
end

for iz = 1:nZ
    Lz(nZ - iz + 2) = Lz(nZ - iz + 1);
end

Lz(1) = 0.;
%% READ : Data
Pz    = zeros(nZ+1, nD);
tline = fgetl(fid);

for iz = 1:nZ
    tline = fgetl(fid);
    Intro = textscan(tline, '%s', 100);
    Lgh   = length(Intro{1});
    
    if Lgh < nD + 1
        error("ERROR : PZ");
    end
    
    for id = 1:nD
        Pz(iz, id) = sscanf(Intro{1}{id+1}, '%f');
    end
end

Pz(nZ+1, :) = Pz(nZ, :);

end