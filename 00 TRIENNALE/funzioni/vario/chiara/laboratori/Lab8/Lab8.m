clear
close all
clc

dt=0.01;
t=-10:dt:10;

x1=sin(pi/2*t);
xq1=myQuant(x1, 2);
figure
plot(t,x1), title ('Segnale originale');
hold on
plot(t,xq1), title ('Segnale quantizzato');

%%
%ESERCIZIO 2

x= 0.5*t.^3+ 5*t.^2-2*(t+10).^2+20;

figure
plot(t, x)

vettore_bit=[2 4 8 16];

for k=1: length(vettore_bit)
   
    bit=vettore_bit(k);
    xq=myQuant(x, bit);
    figure
plot(t,x);
hold on
plot(t,xq), title (sprintf('Segnale quantizzato con %d bit', bit));
figure
plot(t, x-xq), title (sprintf('Segnale errore di quantizzazione con %d bit', bit));
  
differenza= x-xq;
potenza_media= integrale(differenza.^2/(t(end)-t(1)), dt);
fprintf('Potenza media dell''errore di quantizzazione con %dbit : %f', bit, potenza_media)
end

%%NB:
%La potenza media dovrebbe essere uguale a Delta²/12




