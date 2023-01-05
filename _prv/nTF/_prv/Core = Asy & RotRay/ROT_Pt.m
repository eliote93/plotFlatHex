function [OutPt] = ROT_Pt(InnPt, Theta)

OutPt = zeros(1, 2);

OutPt(1) = InnPt(1) * cos(Theta) - InnPt(2) * sin(Theta);
OutPt(2) = InnPt(1) * sin(Theta) + InnPt(2) * cos(Theta);

end

