function [lChk] = CHK_SamePts(Pt01, Pt02)

xTmp = Pt01(1) - Pt02(1);
yTmp = Pt01(2) - Pt02(2);

Tmp = sqrt(xTmp*xTmp + yTmp*yTmp);

lChk = Tmp < 1E-6;

end