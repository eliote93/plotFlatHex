function[T1, T2, T3, T4, nF, nP, nZ] = READ_nTF(Fn)

fid = fopen(Fn);
%% READ : aF2F & pF2F & nZ
while  (~feof(fid))
    tline = fgetl(fid);
    Lgh   = length(tline);
    
    if Lgh < 12
        continue
    end
    
    Intro = textscan(tline, '%s', 100);
    
    if length(Intro{1}) < 2
        continue
    end
    
    if Intro{1}{1} == "pitch"
        aF2F = sscanf(Intro{1}{2}, '%f');
    elseif Intro{1}{1} == "ax_mesh"
        [nZ] = READ_AxMsh(Intro);
    elseif Intro{1}{1} == "assembly"
        pF2F = sscanf(Intro{1}{9}, '%f');
        
        break
    end
end
%% READ : Temp
[ T1, nF ] = READ_Temp(fid, nZ, "Fuel Pin Average Temperature");
[ T2, nF ] = READ_Temp(fid, nZ, "Fuel Center-line Temperature");
[ T3, nF ] = READ_Temp(fid, nZ, "Fuel Surface Temperature");
[ T4, nP ] = READ_Temp(fid, nZ, "Coolant Temperature");

fclose(fid);

end