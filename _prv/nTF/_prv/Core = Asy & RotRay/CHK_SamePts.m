function [tf] = CHK_SamePts(Pt01, Pt02)

dx  = Pt01(1) - Pt02(1);
dy  = Pt01(2) - Pt02(2);
Lgh = sqrt(dx*dx + dy*dy);

tf = Lgh < 1E-7;

end

