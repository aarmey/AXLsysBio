function pp = doAnalysis(colCluster,data)

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
    IGF = (data(ii,3));
    
    clust = (data(ii,find(colCluster))); %#ok<FNDSB>
    
    IGF = (IGF - mean(clust)) / std(clust);
    
    vals(ii) = IGF;
end


[~, pp] = corr(synergy,vals([1 3:end])','type','Spearman');

