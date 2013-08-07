function fits = runGreco(x,DD)

parfor ii = 1:size(DD,1)
    x2 = x;
    x2.D1 = DD(ii,1);
    x2.D2 = DD(ii,2);

    fits(ii) = returnE (x2);
end