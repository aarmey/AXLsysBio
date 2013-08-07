function [logP, out, deltaz2, zsum] = xlinkProc (bRTK, bExp, RTK, SEM, xlink)


for ii = 1:size(RTK,1)
    for jj = 1:size(RTK,2)
        out(ii,jj) = bRTK(jj)*bExp(ii)*RTK(ii,jj); %#ok<AGROW>
        
    end
end


deltaz2 = (out - xlink) ./ SEM;
deltaz = abs(deltaz2);

deltaz(isnan(deltaz)) = 0;


logP = normlike([0 1],reshape(deltaz,[numel(deltaz),1]));

zsum = sum(sum(deltaz));
