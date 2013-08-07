clc; clear;

idxx = 1:66;
idxx = [6 19 20 21 33 41 54];

import bioma.data.*;

data = DataMatrix('File','master.xls');
disp('Data loaded');
names = data.colnames(idxx);


%%

expData = double(data(:,idxx));




Y = pdist(expData','spearman');
Z = linkage(Y,'average');
[H,T,perm] = dendrogram(Z,0);
close(gcf);

expData = expData(:,perm);
[CC, pp] = corr(expData,'type','Spearman');
names = names(perm);

%%%%%%%%%%%%%%%%%%%%%%%%%%%

idx = strfind(names,',');

for ii = 1:length(names)
    names{ii} = names{ii}(1:(idx{ii}-1));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%

pp = reshape(mafdr(reshape(pp,numel(pp),1)),size(pp));


CC(pp > 0.05) = 0;

HMObject = HeatMap(CC,'Colormap','redbluecmap','Symmetric','true',...
    'RowLabels',names,'ColumnLabels',names);