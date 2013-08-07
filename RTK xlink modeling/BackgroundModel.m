clc; clear;


invN = @(p,n) sqrt(-log(1-p)./pi./n);
extt = [1 4];

fplot(@(n) invN(0.01,10.^(n)), extt);
hold on;
fplot(@(n) invN(0.05,10.^(n)), extt);
fplot(@(n) invN(0.5,10.^(n)), extt);
fplot(@(n) invN(0.9,10.^(n)), extt);

axis([1 4 0 0.05]);