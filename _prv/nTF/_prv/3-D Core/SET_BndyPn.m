function [Pn] = SET_BndyPn(Pn, nPin, nCnt, lBndy, l60, lROT)

if ~l60 || ~lROT
    return
end

for iPin = 1:nPin
   if ~lBndy(iPin)
       continue
   end
   
   lSol     = false;
   Cnt(1:2) = nCnt(1:2, 1, iPin);
   
   for jPin = 1:nPin
       if iPin == jPin
           continue
       end
       
       for iFld = 1:6
           [lChk] = CHK_SamePts(Cnt(1:2), nCnt(1:2, iFld, jPin));
           
           if lChk
               break
           end
       end
       
       
       if ~lChk
           continue
       end
       
       Pn(1, iPin) = (Pn(1, iPin) + Pn(1, jPin)) * 0.5;
       lSol        = true;
       
       break
   end
   
   if ~lSol
       error("ERROR");
   end
end

end