function y = myScalarProduct(x,y,dt)

%VARIABILI
% x = segnale 1
% y = segnale 2
% dt = passo

%COSA FA 
%<x,y>=integrale(x(t).y*(t))

y=myIntegrale(x.*conj(y),dt);

