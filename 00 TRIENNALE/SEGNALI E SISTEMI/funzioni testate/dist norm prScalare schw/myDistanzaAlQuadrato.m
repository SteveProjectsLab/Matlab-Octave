function y = myDistanzaAlQuadrato(x,y,dt)

%VARIABILI
% x = segnale 1
% y = segnale 2
% dt = passo

%COSA FA 
% d2^2(x,y) = ||x||^2 + ||y||^2 - 2 Re(<x,y>)

y = myNorm(x,dt)^2 + myNorm(y,dt)^2 -2*real(myScalarProduct(x,y,dt));