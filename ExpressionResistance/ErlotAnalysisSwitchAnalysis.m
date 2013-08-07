clc; clear;

import bioma.data.*;

data = DataMatrix('File','master.xls');

expData = zscore(double(data(:,1:66)));

SensDrug = (data(:,'IC50 (uM) Erlotinib') < 8);
% MET: IC50 (uM) PHA-665752

%----------------------------------------------

idx = nchoosek(1:size(expData,2),1);
N = size(idx,1);


vv = zeros([1 N]);

for ii = 1:N
    idxx = [6 ];%idx(ii,:)];% ]; %  ;%
    randR = [];%randn(488,1);
    
    try
        SVMStruct = svmtrain([expData(:,idxx) randR],SensDrug,...
            'kernel_function','linear','method','QP');

        v = svmclassify(SVMStruct,[expData(:,idxx) randR]);
    
        vv(ii) = sum(v == SensDrug);
        perf{ii} = v == SensDrug;
    catch err
        disp(err)
        vv(ii) = 0;
    end
    
    
    if mod(ii,100) == 0
        disp([mat2str(ii) ' ' mat2str(sum(vv > 336))]);
    end
end




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





