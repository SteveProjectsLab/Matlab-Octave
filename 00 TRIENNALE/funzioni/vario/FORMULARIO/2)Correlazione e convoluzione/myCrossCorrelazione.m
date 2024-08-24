function cross_corr = myCrossCorrelazione( x, y, tau, t, dt)
%MYCROSSCORRELAZIONE Summary of this function goes here
%   Detailed explanation goes here

cross_corr= zeros(1, length(tau));

for k=1: length(tau)
   
    y_traslato= traslazione(y, tau(k), t);
    cross_corr(k)= integrale(conj(x).*y_traslato, dt);
    
end

plot(tau, cross_corr);
end

