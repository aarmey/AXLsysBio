clc; clear;
import bioma.data.*;


data = DataMatrix('File', 'data.xls');

colCluster = [1 1 0 1 1 1 0 0];


% [1 1 0 1 1 1 0 0];

%clustergram(data,'Standardize','Row','Colormap','redbluecmap')
synergy = [0.249
2.13
3.14
1.49
1.73
1.82
1.1
1.46
1.66
1.15];


for ii = 1:size(data,1)
    IGF = double(data(ii,3));
    
    clust = double(data(ii,find(colCluster))); %#ok<FNDSB>
    
    IGF = (IGF - mean(clust)) / std(clust);
    
    vals(ii) = IGF;
end


[cc, pp] = corr(synergy,vals([1 3:end])','type','Spearman');


%%
clc;
idxx = 1;
clear outt;

for ii = 1:1000
    
    idx = [rand rand 0 rand rand rand 0 0] > 0.5;
    
    ppp = doAnalysis(idx,double(data));
    
    if ppp < 0.05
        data.colnames(idx)
        
        outt(:,idxx) = idx;
        idxx = idxx + 1;
    end
    
    
end



%%


X = zscore(double(data([1 3:end],:)'))';
Y = synergy;


[XL,YL,XS,YS,BETA,PCTVAR,MSE,stats] = plsregress(X,Y,7);