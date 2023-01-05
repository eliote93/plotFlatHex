clc;close all;clear;

fid = 'innDLL.out'; % 3KM TASS Input

[nStp, tStp, inDm, inTm, inTfc, inTfs, inPPM, inCR] = READ_innDLL(fid);

EDIT_innDLL(nStp, tStp, inDm, inTm, inTfc, inTfs);