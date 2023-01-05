function [OutPt] = REF_Pt(InnPt, Ang)

OutPt = zeros(1, 2);

L = [cos(Ang), sin(Ang)];
t = L(1) * InnPt(1) + L(2) * InnPt(2);

OutPt(1) = 2. * L(1) * t - InnPt(1);
OutPt(2) = 2. * L(2) * t - InnPt(2);

end