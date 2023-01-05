function [nZ] = READ_AxMsh(Intro)

nS = length(Intro{1});
nZ = 0;

for is = 2:nS
    tline = sscanf(Intro{1}{is}, '%s');
    Lgh   = length(tline);
    
    for ic = 1:Lgh
        if tline(ic) == "*"
            break;
        end
    end
    
    if ic < Lgh
        nZ = nZ + sscanf(tline(1:ic-1), '%d');
    else
        nZ = nZ + 1;
    end
end

end