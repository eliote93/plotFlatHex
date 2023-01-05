function [Pts] = SORT_Pts(Pts, nPt, iPri)

if iPri == 1
  Tmp(1:nPt) = Pts(1, 1:nPt);
else
  Tmp(1:nPt) = Pts(2, 1:nPt);
end

for iPt = 1:nPt - 1
  [v, m] = min(Tmp(iPt:nPt));
  iM     = m + iPt - 1;
  
  PtTmp(1:2)    = Pts(1:2, iPt);
  Pts(1:2, iPt) = Pts(1:2, iM);
  Pts(1:2, iM)  = PtTmp(1:2);
  
  TT       = Tmp(iPt);
  Tmp(iPt) = Tmp(iM);
  Tmp(iM)  = TT;
end

end