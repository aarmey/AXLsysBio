
clc; clear;
% Significance of correlation in vivo


data = xlsread('breastData.xls');
format longE

[cc, pp] = corr(data,'type','Spearman')