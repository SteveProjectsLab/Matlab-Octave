function y = traslazione(x, tau ,t)
%TRASLAZIONE Summary of this function goes here
%   Detailed explanation goes here

indice=t+tau;
t=indice;
y=x;

hold on
plot(t, y, 'r--')
end

