% For calculating Lowe synergy
% Data processing

clc; clear;

data = csvread('549.csv');

xAx = data(1,2:end);
yAx = data(2:end,1);
data(1,:) = [];
data(:,1) = [];

idx = 1;
for ii = 1:length(xAx)
    for jj = 1:length(yAx)
        
        DD(idx,1) = xAx(ii);
        DD(idx,2) = yAx(jj);
        viab(idx) = data(jj,ii);
        idx = idx + 1;
    end
end

viab = viab / max(viab);

DD = DD + 0.001;

clear data xAx yAx ii jj idx;

% Do the actual fitting

%matlabpool(8);

[xOut,R,J] = nlinfit(DD,viab,@(xP,DD)runGreco(deParm(xP),DD),...
    [1.1777 22.817 -0.5662 -2.4176 -1.5709],statset('Display','iter'));

%matlabpool('close');


ci = nlparci(xOut,R,'jacobian',J,'alpha',0.001);
xOut2 = deParm(xOut);
fits = runGreco(xOut2,DD);

clear R J xOut;