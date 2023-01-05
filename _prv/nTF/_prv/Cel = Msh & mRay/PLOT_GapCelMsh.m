function PLOT_GapCelMsh(pF2F, nPin, aiF2F, aoF2F)

% ASSUME : nHor, nVer is fixed as nP = 3 problem

gHgt = 0.5 * (aoF2F - aiF2F);

aiPch = aiF2F / sqrt(3.);
aoPch = aoF2F / sqrt(3.);

tLgh = 0.5 * (aoPch - pF2F * (nPin - 2)) - pF2F/4.;
bLgh = 0.5 * (aiPch - pF2F * (nPin - 2)) - pF2F/4.;

pVtx = zeros(2, 5);

pVtx(1, 1) = -tLgh; pVtx(2, 1) =  gHgt * 0.5;
pVtx(1, 2) =  tLgh; pVtx(2, 2) =  gHgt * 0.5;
pVtx(1, 3) =  bLgh; pVtx(2, 3) = -gHgt * 0.5;
pVtx(1, 4) = -bLgh; pVtx(2, 4) = -gHgt * 0.5;

pVtx(:, 5) = pVtx(:, 1);

for iBndy = 1:5
    pVtx(1:2, iBndy) = RotPt(pVtx(1:2, iBndy), -pi/6.);
end

for iBndy = 1:4
    PLOT_Seg(pVtx(1:2, iBndy), pVtx(1:2, iBndy+1), 4, 'r')
end

mVtx01 = zeros(2, 10);
mVtx02 = zeros(2, 10);
xDel   = pF2F / 8;

for iDir = 1:4
    mVtx01(1, iDir) = xDel * iDir; mVtx01(2, iDir) =  gHgt * 0.5;
    mVtx02(1, iDir) = xDel * iDir; mVtx02(2, iDir) = -gHgt * 0.5;
    
    mVtx01(1, 4 + iDir) = -xDel * iDir; mVtx01(2, 4 + iDir) =  gHgt * 0.5;
    mVtx02(1, 4 + iDir) = -xDel * iDir; mVtx02(2, 4 + iDir) = -gHgt * 0.5;
end

mVtx01(2, 9) =  gHgt * 0.5; mVtx01(1, 10) =  0.5 * (tLgh + bLgh);
mVtx02(2, 9) = -gHgt * 0.5; mVtx02(1, 10) = -0.5 * (tLgh + bLgh);

for iBndy = 1:10
    mVtx01(1:2, iBndy) = RotPt(mVtx01(1:2, iBndy), -pi/6.);
    mVtx02(1:2, iBndy) = RotPt(mVtx02(1:2, iBndy), -pi/6.);
end

for iBndy = 1:10
    if iBndy == 2 || iBndy == 6
        n = 4; a = 'r';
    else
        n = 1; a = 'k';
    end
    
    PLOT_Seg(mVtx01(1:2, iBndy), mVtx02(1:2, iBndy), n, a);
end

xlim([-tLgh tLgh]);
ylim([-tLgh tLgh]);

end

