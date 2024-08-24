function y = myCorrelazioneLin(x,y,dt)

%VARIABILI
% x = segnale 1
% y = segnale 2 (di tau)
% dt passo

%COSA FA 
%phi_xy(tau) = <y(tau),x> = integrale(x*(t).y(t+tau))

y=myScalarProduct(y,x,dt);
