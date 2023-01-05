function [tf] = CHK_SameEqns(Eqn01, Eqn02)

% ASSUME : Eqn is not parallel to x-axis
Slp01 = Eqn01(1)/Eqn01(2);
Slp02 = Eqn02(1)/Eqn02(2);
Tmp01 = Eqn01(3)/Eqn01(2);
Tmp02 = Eqn02(3)/Eqn02(2); 

tf01 = CHK_SameVal(Slp01, Slp02);
tf02 = CHK_SameVal(Tmp01, Tmp02);

tf = tf01 && tf02;

end

