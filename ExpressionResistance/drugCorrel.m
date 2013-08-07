clc; clear;

import bioma.data.*;

data = DataMatrix('File','master.xls');
disp('Data loaded');

%data = data(:,67:end);

actArea = data(:,139:end);



A = corr(double(actArea),'type','Spearman','rows','pairwise');



[Y,e] = cmdscale(A);


plot(Y(:,1),Y(:,2),'o');
text(Y(:,1),Y(:,2),actArea.colnames);