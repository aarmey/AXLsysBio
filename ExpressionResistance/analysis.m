clc; clear;


load ErlotAllThree;



clear N ans SensDrug expData;

for ii = 1:max(max(idx))
    select = logical(sum(idx == ii,2));
    
    
    sel = vv(select);
    Nsel = vv(~select);
    
    p(ii) = ranksum(sel,Nsel,'tail','right')
end