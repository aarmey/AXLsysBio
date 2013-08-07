clear; clc;

[data, txt] = xlsread('ErlotEff.xls');

mdl = LinearModel.stepwise(data(:,1:6),data(:,7),'interactions','VarNames',txt)
