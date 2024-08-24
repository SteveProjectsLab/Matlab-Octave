clear
close all
clc

dt = 0.01;
t = -10:dt:10;
df = dt;
f = -15:df:15;
x=cos(t);
%x=sin(t);
%x= 4*exp(-10*t.^2);%gaussiana
%x = 8*sinc(t/2); % Cambiare il segnale a seconda dell'esercizio
figure(1),set(1, 'WindowStyle', 'docked');
plot(t,x), title('x')

X = T_Fourier(x,t,f); %calcolo la TDF
figure(2),set(2, 'WindowStyle', 'docked');
plot(f,abs(X)), title('X')

origine = ceil(length(t)/2);%ci interessa il 1001 campione
count=3;
r=4;%righe subplot
c=1;%colonne subplot
for n = 10:5 :50 %va da 10 con passo 10 fino a 50
    Tc = n*dt; %tempo di campionamento
    %tutti i campioni eccetto uno ogni 10
    tsample = mod(origine,n):n:length(t);% indice dei campioni che voglio campionare
    %mod è il resto, finisco in 1001
    %quel vettore ci permette di prendere il segnale a t=0
    xc = zeros(1,length(t));% inizializzo il vettore di zeri
    xc(tsample) = x(tsample);%tutti zeri tranne in cui il segnale è uguale al segnale originale
    figure(count),set(count, 'WindowStyle', 'docked')
    subplot(r,c,1),stem(t,xc), title(sprintf('Segnale campionato xc, con Tc=%.2f',Tc))
    
    % Calcolo TdF
    Xc = T_Fourier(xc,t,f);
    subplot(r,c,2), plot(f,abs(Xc)), title(sprintf('Spettro segnale campionato Xc, con Tc=%.2f',Tc))
    
    % Interpolazione ideale
    xr_i = zeros(1,length(t));
    for k = 1:length(tsample)
        xr_i = xr_i + xc(tsample(k))*sinc((t-t(tsample(k)))/Tc);
    end
     subplot(r,c,3),plot(t,xr_i,t,x), title(sprintf('Segnale ricostruito idealmente xr_i, con Tc=%.2f',Tc))
    fprintf('Energia dell''errore di ricostruzione con interpolatore ideale e Tc=%.3f: %.3f\n',...
        Tc, integrale(abs(x-xr_i).^2,dt))
    
    % ZOH interpolazione col mantenimento
    x_ZOH = zeros(1,length(t));
    for k = 1:length(tsample)-1%perchè se no avrebbe dato errore
        %mantenere il campione finchè non trovo il successivo
        x_ZOH(tsample(k):tsample(k+1)-1) = xc(tsample(k));
    end
    x_ZOH(tsample(end):end) = xc(tsample(end));
    subplot(r,c,4), plot(t,x_ZOH,t,x), title(sprintf('Segnale ricostruito mediante interpolazione ZOH xZOH, con Tc=%.2f',Tc))
    fprintf('Energia dell''errore di ricostruzione mediante interpolazione ZOH e Tc=%.3f: %.3f\n',...
        Tc, integrale(abs(x-x_ZOH).^2,dt))
    count=count+1;%serve per i grafici
end