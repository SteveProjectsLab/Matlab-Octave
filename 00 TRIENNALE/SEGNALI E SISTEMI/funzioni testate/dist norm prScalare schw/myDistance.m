function y = myDistance(x,y,dt)

%VARIABILI
% x = segnale 1
% y = segnale 2
% dt = passo

%COSA FA 
% d2(x,y) = ||x-y|| = sqrt(energia(x-y))

y=sqrt(myEnergia((x-y),dt));