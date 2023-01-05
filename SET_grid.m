function [XX, YY, xymx] = SET_grid(ndat, grdrad)

XX = [];
YY = [];
X  = zeros(1,6);
Y  = zeros(1,6);

for ixy = 1:ndat(1,1)
    X(1:6) = grdrad(ixy, 1:6);
    Y(1:6) = grdrad(ixy, 7:12);
    
    XX = [XX;X];
    YY = [YY;Y];
end

xymx(1, 1) = min(min(XX)); xymx(1, 2) = max(max(XX));
xymx(2, 1) = min(min(YY)); xymx(2, 2) = max(max(YY));

end