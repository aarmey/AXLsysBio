clc; clear;

import bioma.data.*;

data = DataMatrix('File','master.xls');

expData = zscore(double(data(:,1:66)));

SensDrug = (data(:,'IC50 (uM) Erlotinib') < 8);
% MET: IC50 (uM) PHA-665752

%----------------------------------------------

idx = nchoosek(1:size(expData,2),3);
N = size(idx,1);


vv = zeros([1 N]);

matlabpool(8);

parfor_progress(N);

parfor ii = 1:N
    idxx = idx(ii,:);% ]; %  ;%
    randR = [];%randn(488,1);
    
    try
        SVMStruct = svmtrain([expData(:,idxx) randR],SensDrug,...
            'kernel_function','linear','method','QP');
    
        vv(ii) = sum(svmclassify(SVMStruct,[expData(:,idxx) randR]) == SensDrug);
    catch err
        disp(err)
        vv(ii) = 0;
    end
    
    
    parfor_progress;
end

parfor_progress(0);

matlabpool('close');


vv = vv ./ length(v);
bar(vv)



