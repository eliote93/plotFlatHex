function [nStp, tStp, inDm, inTm, inTfc, inTfs, inPPM, inCR] = READ_innDLL(fid)

gid = fopen(fid);
%% SCAN
for inn = 1:41
    tline = fgetl(gid);
end

nStp = 0;

while  (~feof(gid))
    for inn = 1:39
        tline = fgetl(gid);
    end
    
    nStp = nStp + 1;
end

fclose(gid);
%% ALLOC : Fixed Dimension
tStp  = zeros(1,     nStp);
inDm  = zeros(2, 12, nStp);
inTm  = zeros(2, 12, nStp);
inTfc = zeros(2, 12, nStp);
inTfs = zeros(2, 12, nStp);
inPPM = zeros(2, 12, nStp);
inCR  = zeros(   12, nStp);
%% READ
gid = fopen(fid);

for inn = 1:41
    tline = fgetl(gid);
end

nStp = 0;

while  (~feof(gid))
    nStp = nStp + 1;
    
    for inn = 1:3
        tline = fgetl(gid);
    end
    
    Intro = textscan(tline, '%s', 100);
    tStp(nStp) = sscanf(Intro{1}{2}, '%f');
    
    for inn = 1:4
        tline = fgetl(gid);
    end
    
    % Mod. Dens.
    tline = fgetl(gid);
    Intro = textscan(tline, '%s', 100);
    for inn = 1:12
        inDm(1, inn, nStp) = sscanf(Intro{1}{inn+1}, '%f');
    end
    tline = fgetl(gid);
    Intro = textscan(tline, '%s', 100);
    for inn = 1:12
        inDm(2, inn, nStp) = sscanf(Intro{1}{inn+1}, '%f');
    end
    
    for inn = 1:4
        tline = fgetl(gid);
    end
    
    % Mod. Dens.
    tline = fgetl(gid);
    Intro = textscan(tline, '%s', 100);
    for inn = 1:12
        inTm(1, inn, nStp) = sscanf(Intro{1}{inn+1}, '%f');
    end
    tline = fgetl(gid);
    Intro = textscan(tline, '%s', 100);
    for inn = 1:12
        inTm(2, inn, nStp) = sscanf(Intro{1}{inn+1}, '%f');
    end
    
    for inn = 1:4
        tline = fgetl(gid);
    end
    
    % Fuel. Cnt. Temp.
    tline = fgetl(gid);
    Intro = textscan(tline, '%s', 100);
    for inn = 1:12
        inTfc(1, inn, nStp) = sscanf(Intro{1}{inn+1}, '%f');
    end
    tline = fgetl(gid);
    Intro = textscan(tline, '%s', 100);
    for inn = 1:12
        inTfc(2, inn, nStp) = sscanf(Intro{1}{inn+1}, '%f');
    end
    
    for inn = 1:4
        tline = fgetl(gid);
    end
    
    % Fuel. Surf. Temp.
    tline = fgetl(gid);
    Intro = textscan(tline, '%s', 100);
    for inn = 1:12
        inTfs(1, inn, nStp) = sscanf(Intro{1}{inn+1}, '%f');
    end
    tline = fgetl(gid);
    Intro = textscan(tline, '%s', 100);
    for inn = 1:12
        inTfs(2, inn, nStp) = sscanf(Intro{1}{inn+1}, '%f');
    end
    
    for inn = 1:4
        tline = fgetl(gid);
    end
    
    % Boron Conc.
    tline = fgetl(gid);
    Intro = textscan(tline, '%s', 100);
    for inn = 1:12
        inPPM(1, inn, nStp) = sscanf(Intro{1}{inn+1}, '%f');
    end
    tline = fgetl(gid);
    Intro = textscan(tline, '%s', 100);
    for inn = 1:12
        inPPM(2, inn, nStp) = sscanf(Intro{1}{inn+1}, '%f');
    end
    
    for inn = 1:4
        tline = fgetl(gid);
    end
    
    % CR Pos.
    tline = fgetl(gid);
    Intro = textscan(tline, '%s', 100);
    for inn = 1:12
        inCR(inn, nStp) = sscanf(Intro{1}{inn}, '%f');
    end
    
    tline = fgetl(gid);
end

fclose(gid);
end