function [tf] = CHK_SameVal(Val01, Val02)

Del = abs(Val01 - Val02);
tf  = Del < 1E-7;

end

