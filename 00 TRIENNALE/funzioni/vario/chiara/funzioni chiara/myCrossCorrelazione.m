function Phi = myCrossCorrelazione( x, y, tau, t, dt)
%MYCROSSCORRELAZIONE Summary of this function goes here
%   Detailed explanation goes here

Phi= zeros(1, length(tau));

for k=1: length(tau)
   
    Phi(k)= integrale(conj(x(t)).*y(t+tau(k)), dt);
    
end


