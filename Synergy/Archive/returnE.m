function E = returnE (x)

% Always scale E from 0 to 1

ErrVal = @(EE) (x.D1/(x.IC501*((EE / (1-EE))^(1/x.m1)))) ...
    + ( x.D2 / (x.IC502 *((EE/(1-EE)) ^(1/x.m2)))) ...
    + x.a*x.D1*x.D2/(x.IC501*x.IC502*((EE/(1-EE))^(1/(2*x.m1)+1/(2*x.m2))))-1;

E = lsqnonlin(ErrVal,0.5,0,1,optimset('Display','off'));