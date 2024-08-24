function [X] = trasFourier(x,t,f)
%UNTITLED fourier tranform of x 
%   Detailed explanation goes here
dt=t(2)-t(1);
%{
X=zeros(size(f));
for k=1:length(f)
    X(k)=integrale(x.*exp(-1j*2*pi*f(k)*t),dt);
end
%}
X=dt*x*exp(-1j*2*pi*t'*f);
% matrice che ha nelle colonne la funzione per esponenziale complesso alla
% frequenza dell'iesima colonna
end

