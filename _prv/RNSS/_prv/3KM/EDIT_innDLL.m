function EDIT_innDLL(nStp, tStp, inDm, inTm, inTfc, inTfs)

fid = fopen('innDLL.plt', 'w');

fprintf(fid, 'Time(sec) TFMAX(C)  TFAVG(C)  TMMAX(C)  TMAVG(C)  DMAVG(kg/m3)\n');

tfws = 1.;

for iStp = 1:nStp
    TFMAX = max(max(inTfs(1:2, 1:12, iStp)));
    TMMAX = max(max(inTm (1:2, 1:12, iStp)));
    TMAVG = sum(sum(inTm (1:2, 1:12, iStp))) / 24.;
    DMAVG = sum(sum(inDm (1:2, 1:12, iStp))) / 24.;
    
    TFAVG = (1. - tfws) * sum(sum(inTfc(1:2, 1:12, iStp))) / 24. + tfws * sum(sum(inTfs(1:2, 1:12, iStp))) / 24.;
    
    fprintf(fid, '%6.2f    %8.4f  %8.4f  %8.4f  %8.4f  %8.4f\n', tStp(iStp), TFMAX, TFAVG, TMMAX, TMAVG, DMAVG);
end

fclose(fid);

end