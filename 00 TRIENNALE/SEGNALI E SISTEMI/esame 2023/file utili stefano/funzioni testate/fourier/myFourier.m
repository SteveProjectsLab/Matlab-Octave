function X = myFourier (x,t,f)

%VARIABILI
% x = vettore di valori
% t = vettore dei tempi
% f = vettore delle frequenza

%COSA FA 
% calcola la tdf del segnale x

dt=t(2)-t(1);% dato che non gli passo il dt nella funzione, lo ricavo
X= zeros(1,length(f)); 

for k =1:length(f)
  %calcolo l'integrale sul vettore delle frequenza
   X(k)= myIntegrale(x.*exp(-1j*2*pi*t*f(k)),dt);
end