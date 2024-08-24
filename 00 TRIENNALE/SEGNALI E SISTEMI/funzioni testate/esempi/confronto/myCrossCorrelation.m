function [phi] = myCrossCorrelation(x,y,t,tau,dt)
%UNTITLED restituisce la funzione cross-correlazione phi(tau)
%   Detailed explanation goes here
phi=zeros(1,length(tau));

for k=1:length(tau)
    ytau=myTranslation(y,tau(k),t,dt);
    phi(k)=myScalarProduct(ytau,x,dt);
end
end

