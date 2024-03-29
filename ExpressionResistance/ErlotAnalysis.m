clc; clear;

import bioma.data.*;

data = DataMatrix('File','master.xls');

expData = zscore(double(data(:,1:66)));

SensDrug = (data(:,'IC50 (uM) Lapatinib') < 8);
% MET: IC50 (uM) PHA-665752

%----------------------------------------------

idx = nchoosek(1:size(expData,2),1);
N = 1e6;%size(idx,1);


vv = zeros([1 N]);

for ii = 1:N
    idxx = [];%idx(ii,:)];% ]; %  ;%
    randR = randn(488,2);
    
    try
        SVMStruct = svmtrain([expData(:,idxx) randR],SensDrug,...
            'kernel_function','linear','method','QP');

        v = svmclassify(SVMStruct,[expData(:,idxx) randR]);
    
        vv(ii) = sum(v == SensDrug);
    catch err
        disp(err)
        vv(ii) = 0;
    end
    
    
    if mod(ii,100) == 0
        disp([mat2str(ii) ' ' mat2str(sum(vv > 307))]);
        hist(vv(vv ~= 0)/488,20);
        drawnow;
    end
end


close(h)


vv = vv ./ length(v);
bar(vv)

%%
% clc;
% idx = regexp(data.rownames,'BREAST');
% idxx = zeros(size(idx));
% 
% for ii = 1:length(idx)
%     
%     if ~isempty(idx{ii})
%         
%         disp(data.rownames{ii});
%         disp(v(ii));
%         disp(SensDrug(ii));
%         idxM(ii) = 1;
%         
%         
%     end
% end
% 
% idxM = find(idxM);












%%

% goodMap = [];
% goodIDX = find(vv > 0.6);
% 
% for ii = 1:length(goodIDX)
%     goodMap(ii,idx(goodIDX(ii),:)) = 1;
% end
% 
% hygecdf(sum(goodMap),numel(goodMap),sum(sum(goodMap)),size(goodMap,1)) > 0.95

%%


% 
% for ii = 1:10000
%     v2 = v(randperm(size(v,1)),:);
%     vvRand(ii) = sum(v == v2);
% end
% 
% vvRand = vvRand ./ length(v);
% 




%%
clc;

idxx = [6 19 54];

SVMStruct = svmtrain(expData(:,idxx),SensDrug, ...
    'kernel_function','linear','method','QP','showplot','false');

v = svmclassify(SVMStruct,expData(:,idxx));
sum(v == SensDrug) / length(v)

bars = [v SensDrug];



%plot(double(data(:,54)),double(data(:,6)),'ko')




