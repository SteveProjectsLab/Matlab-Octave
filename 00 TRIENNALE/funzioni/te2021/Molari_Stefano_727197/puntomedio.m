function xmedio = puntomedio(x,dt)

%VARIABILI
% x = vettore di valori
% dt = passo

N = length(x); %lunghezza del vettore x

%COSA FA 
%somma tutti i valori presenti nel vettore dt
xmedio=0;

for i=1:N-1
    xmedio= xmedio+(x(i)+x(i)+1)/2;
end

