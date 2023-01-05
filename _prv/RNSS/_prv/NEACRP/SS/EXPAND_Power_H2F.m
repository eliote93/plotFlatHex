function [Pr1d, nX, nA, nY] = EXPAND_Power_H2F(Pr1d_T, nX_T, nA_T, nY_T)
% ASSUME : Lower Half
% ASSUME : # of rows is odd

if mod(nX_T(1), 2) ~= 1
    error('UNDERCONSTRUCTION')
end

nA = 2 * nA_T - nX_T(1);
nY = 2 * nY_T - 1;

Pr1d = zeros(1, nA);
nX   = zeros(1, nY);
jAsy = 0;

for iy = 1:nY_T
    jy  = nY_T - iy + 1;
    iSt = sum(nX_T(1:jy-1)) + 1;
    
    nX(iy) = nX_T(jy);
    
    for ix = 1:nX(iy)
        jAsy = jAsy + 1;
        
        Pr1d(jAsy) = Pr1d_T(iSt + ix - 1);
    end
end

for iy = 2:nY_T
    jy  = nY_T + iy - 1;
    iSt = sum(nX_T(1:iy-1)) + 1;
    
    nX(jy) = nX_T(iy);
    
    for ix = 1:nX(jy)
        jAsy = jAsy + 1;
        
        Pr1d(jAsy) = Pr1d_T(iSt + ix - 1);
    end
end

end