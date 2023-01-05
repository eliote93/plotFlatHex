function [Pr1d, nX, nA] = EXPAND_Power_Q2H(Pr1d_T, nX_T, nA_T, nY_T)
% ASSUME : SE Quarter
% ASSUME : # of rows is odd

nA = 2 * nA_T - nY_T;

Pr1d = zeros(1, nA);
nX   = zeros(1, nY_T);
jAsy = 0;
iSt  = 1;

for iy = 1:nY_T
    nX(iy) = 2 * nX_T(iy) - 1;
    
    for ix = 1:nX_T(iy)
        jAsy = jAsy + 1;
        
        Pr1d(jAsy) = Pr1d_T(iSt + nX_T(iy) - ix);
    end
    
    for ix = 2:nX_T(iy)
        jAsy = jAsy + 1;
        
        Pr1d(jAsy) = Pr1d_T(iSt + ix - 1);
    end
    
    iSt = iSt + nX_T(iy);
end

end