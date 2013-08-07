clc; clear;

import bioma.data.*;

data = DataMatrix('File','master.xls');
disp('Data loaded');

data = data(:,1:66);

[cc, pp] = corr(double(data),'type','Spearman');

cc(pp > 0.05) = 0;

corrmap(double(data),data.colnames,1);


%% Random data

for ii = 1:1000
    [ccR, ppR] = corr(randn(488,66),'type','Spearman');

    pppRR(ii) = sum(sum(ppR < 0.05));
end



%%


[~,~,~,~,explained] = pca(zscore(log(double(data))));


[coeff,score,latent,tsquared,explained2] = pca(zscore(log(double(randn([488 66])))));


figure()
pareto(explained)
xlabel('Principal Component')
ylabel('Variance Explained (%)')

figure()
pareto(explained2)
xlabel('Principal Component')
ylabel('Variance Explained (%)')




%%

for ii = 1:1000
    [coeff,score,latent,tsquared,explained2] = pca(zscore(log(double(randn([488 66])))));
    
    expp(:,ii) = explained2;
    
end

