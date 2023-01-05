function PLOT_Flx_Tri(aF2F, Poly, ipa, ind, ig, ndiv)

SQ3 = sqrt(3.);
Tmp = aF2F / 3.;

%% SET : xy
dx = (aF2F * 0.5) / (2^ndiv);

xcor = -Tmp : dx : Tmp * 0.5;
ncor = size(xcor, 2);
npt  = ncor * (ncor + 1) / 2;
xx   = zeros(npt, 1);
yy   = zeros(npt, 1);
zz   = zeros(npt, 1);

ib = 1;

for ipt = 1:ncor
    nx  = ipt;
    ie = ib + nx - 1;
    
    xx(ib:ie) = -Tmp + (ipt-1) * dx;
    
    ib = ie + 1;
end

ib = 1;

for ipt = 1:ncor
    ny   = ipt;
    ie   = ib + ny - 1;
    ybot = -((ipt-1) * dx) / SQ3;
    
    for iy = ib:ie
        yy(iy) = ybot + (2. * dx / SQ3) * (iy - ib);
    end
    
    ib = ie + 1;
end
%% CAL : Flx
Cff = zeros(9, 1);

Cff(1:9) = Poly(1:9, ig, ind, ipa);

for ipt = 1:npt
    x = xx(ipt);
    y = yy(ipt);
    u = -0.5 * xx(ipt) - SQ3 * 0.5 * yy(ipt);
    p = -0.5 * xx(ipt) + SQ3 * 0.5 * yy(ipt);
    
    z1 = Cff(1)         + Cff(2) * x     + Cff(3) * y;
    z2 = Cff(4) * x*x   + Cff(5) * u*u   + Cff(6) * p*p;
    z3 = Cff(7) * x*x*x + Cff(8) * u*u*u + Cff(9) * p*p*p;
    
    zz(ipt) = z1 + z2 + z3;
end
%% ROT : Pt
xx  = xx + Tmp;
ang = -(ind - 4) * pi / 3.;
ct  = cos(ang);
st  = sin(ang);

for ipt = 1:npt
    x = xx(ipt);
    y = yy(ipt);
    
    xx(ipt) = ct * x - st * y;
    yy(ipt) = st * x + ct * y;
end

tri = delaunay(xx, yy);

trisurf(tri, xx, yy, zz);
end