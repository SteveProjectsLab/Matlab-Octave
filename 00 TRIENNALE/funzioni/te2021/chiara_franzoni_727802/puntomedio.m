function I = puntomedio(x,dt)
%PUNTOMEDIO Summary of this function goes here
%   Detailed explanation goes here
N= length(x);
xi=x;
somma=0;
for k=1: N-1
    somma=somma+(xi(k)+xi(k+1))/2;
end

I=dt*somma;
end

