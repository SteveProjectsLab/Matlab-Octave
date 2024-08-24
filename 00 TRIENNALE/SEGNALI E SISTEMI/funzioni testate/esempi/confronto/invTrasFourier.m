function [x] = invTrasFourier(X,f,t)
%UNTITLED fourier tranform of x 
%   Detailed explanation goes here
df=f(2)-f(1);
%{
x=zeros(size(t));
for k=1:length(t)
    x(k)=integrale(X.*exp(1j*2*pi*f*t(k)),df);
end
%}
x=df*X*exp(1j*2*pi*f'*t);
end

