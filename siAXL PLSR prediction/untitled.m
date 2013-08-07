clc; clear;

import bioma.data.*;

Q2fun = @(YYP,testfit) corr(YYP,testfit,'type','Pearson');

sig = DataMatrix('File','forPLSR.xls');

sig = sig';

sigPLS = zscore(double(sig(5:end,:)));
sigPLS2 = zscore(double(sig(:,1:end-1)));


idx = 1:5;
idxes = nchoosek(1:11,3);

%idxes = [2 5 7 9 11];
for ii = 1:size(idxes,1)
    
    X = sigPLS(:,idxes(ii,:));

    [XLA, XLjk, XLS, XSjk, VIPa, VIPjk,testfit,testerror] = jackyknife(sigPLS(:,idxes(ii,:)),sigPLS(:,end),2);

    result(ii) = Q2fun(sigPLS(:,end),testfit);

end

chosen = [];
goodNum = 0;
goodYLs = [];
goodXSs = [];
goodYSs = [];

for ii = 1:11
    XLs{ii} = [];
end

for ii = 1:length(result)
    
    if result(ii) > 0.9
        goodNum = goodNum + 1;
        vec = zeros(11,1);
        vec(idxes(ii,:)) = 1;
        
        chosen(end+1,:) = vec;
        
        
        % work with the good variable set
        goodIDX = idxes(ii,:);
        X = sigPLS(:,goodIDX);
        [XL,YL,XS,YS,BETA] = plsregress(X,sigPLS(:,end),2);
        
        goodYLs(end+1,:) = YL;
        
        % save weights
        for jj = 1:length(goodIDX)
            XLs{goodIDX(jj)}(end+1,:) = [XL(jj,1) XL(jj,2)];
            
        end
        
        
        Y = [ones(8,1),sigPLS2(:,goodIDX)]*BETA;
        Y(1:4) = Y(1:4) - Y(4);
        Y(5:8) = Y(5:8) - Y(8);
        
        Ys(:,size(chosen,1)) = Y;
    end
end

freq = sum(chosen);

ppp = hygepdf(freq,numel(chosen),sum(sum(chosen)),size(chosen,1));





%%
clc;

sigZ = zscore(double(sig(:,1:11)));



[coeff,score,latent,tsquared,explained] = pca(sigZ);

%%



clustergram(log(sig(:,1:(end-1))),'Standardize','None','Colormap',redbluecmap)
