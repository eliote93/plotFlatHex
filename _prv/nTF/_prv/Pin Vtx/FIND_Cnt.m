function [Cnt] = FIND_Cnt(nPt, Pts)

Cnt = zeros(1, 2);

PtsTmp(1:2, 1:nPt)   = Pts   (1:2, 1:nPt);
PtsTmp(1:2, nPt + 1) = PtsTmp(1:2, 1);

Are = 0.;

for iPt = 1:nPt
  Are = Are + PtsTmp(1, iPt) * PtsTmp(2, iPt + 1) ...
            - PtsTmp(2, iPt) * PtsTmp(1, iPt + 1);
end

Are = Are * 0.5;

for iCor = 1:2
  Tmp = 0.;
  
  for iPt = 1:nPt
    Tmp01 = PtsTmp(iCor, iPt) + PtsTmp(iCor, iPt + 1);
    Tmp02 = PtsTmp(1, iPt) * PtsTmp(2, iPt + 1) ...
          - PtsTmp(2, iPt) * PtsTmp(1, iPt + 1);
    Tmp   = Tmp + Tmp01 * Tmp02;
  end
  
  Cnt(iCor) = Tmp / Are / 6.;
end

end

