function x = myFourierInv (X,f,t)

%VARIABILI
% X = vettore di valori
% f = vettore delle frequenza
% t = vettore dei tempi

%COSA FA 
% calcola l'anti trasformata di fourier del segnale x
df = f(2)-f(1);% dato che non gli passo il df nella funzione, lo ricavo

x = zeros(1,length(t)); % inizializzo il vettore

for k =1:length(t)
   %calcolo l'integrale sul vettore delle frequenza
   x(k)= myIntegrale(X.*exp(+1j*2*pi*f*t(k)),df);
end