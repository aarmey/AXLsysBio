% mixed effects
clc; clear;


import bioma.data.*;




data = DataMatrix('File','RTK.xls');

RTK = double(data(1:5,:));

xlink = double(data(6:10,:));

xSEM = double(data(11:15,:));

%%

clc;

numVar = 12;

funcc = @(x) xlinkProc (x(1:7), x(8:12), RTK, xSEM, xlink);

[x,fval,exitflag,output,lambda,grad,hessian] = ...
    fmincon(funcc, randn(numVar,1)*0.05, zeros(1,numVar), 0, zeros(1,numVar), 0, zeros(numVar,1), ones(numVar,1));


[~, out, deltaz, ~] = xlinkProc (x(1:7), x(8:12), RTK, xSEM, xlink);

out2 = reshape(out,[numel(out),1]);
xlink2 = reshape(xlink,[numel(xlink),1]);

out2(isnan(xlink2)) = [];
xlink2(isnan(xlink2)) = [];



%%

for ii = 1:12
    Aeq = zeros(1,12);
    Aeq(ii) = 1;
    
    [~,fval2] = fmincon(funcc, x, zeros(1,12), 0, Aeq, 0, zeros(12,1), ones(12,1));
    
    LLp(ii) = fval2 - fval;
    
end


%%


newAmt = linspace(0,0.1,100);

for ii = 1:length(newAmt)
    Aeq = zeros(1,11);
    Aeq(2) = 1;
    
    [~,fval3] = fmincon(funcc, x, zeros(1,11), 0, Aeq, newAmt(ii), zeros(11,1), ones(11,1));
    
    if fval3 - fval > 2
        new1 = ii;
        break;
    end
    
end

for ii = 1:length(newAmt)
    
    Aeq2 = zeros(1,11);
    Aeq2(6) = 1;
    
    [~,fval3] = fmincon(funcc, x, zeros(1,11), 0, Aeq2, newAmt(ii), zeros(11,1), ones(11,1));
    
    if fval3 - fval > 2
        new2 = ii;
        break;
    end
end





