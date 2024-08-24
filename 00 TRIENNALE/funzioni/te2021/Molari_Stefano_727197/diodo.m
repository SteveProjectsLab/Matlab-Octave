function out= puntomedio(x)

%VARIABILI
% x = vettore di valori
% dt = passo

N = length(x); %lunghezza del vettore x

%COSA FA 
%somma tutti i valori presenti nel vettore dt
out=0;

for i=1:N-1
    out= out+(x(i)+x(i)+1)/2;
end

