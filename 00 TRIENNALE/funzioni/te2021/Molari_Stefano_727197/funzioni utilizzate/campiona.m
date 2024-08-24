function campiona(x,da,passo,a,t,f,tipo,figura)
dt=t(2)-t(1);
df=f(2)-f(1);

figure(figura),set(figura, 'WindowStyle', 'docked');
plot(t,x), title('x')

X = myFourier(x,t,f); %calcolo la TDF
figure(figura+1),set(figura+1, 'WindowStyle', 'docked');
plot(f,abs(X)), title('X')

origine = ceil(length(t)/2);%ci interessa il 1001 campione
count=figura+2;%numero di partenza della prossima figura
r=3;    %righe subplot
c=1;    %colonne subplot
for n = da:passo:a %va da 10 con passo 10 fino a 50
    Tc = n*dt; %tempo di campionamento
    %tutti i campioni eccetto uno ogni 10
    tsample = mod(origine,n):n:length(t);% indice dei campioni che voglio campionare
    %mod è il resto, finisco in 1001
    %quel vettore ci permette di prendere il segnale a t=0
    xc = zeros(1,length(t));% inizializzo il vettore di zeri
    xc(tsample) = x(tsample);%tutti zeri tranne in cui il segnale è uguale al segnale originale
    figure(count),set(count, 'WindowStyle', 'docked')
    subplot(r,c,1),stem(t,xc), title(sprintf('Segnale campionato x_c, con T_c=%.2f',Tc))
    
    % Calcolo TdF
    Xc = myFourier(xc,t,f);
    subplot(r,c,2), plot(f,abs(Xc)), title(sprintf('Spettro segnale campionato X_c, con T_c=%.2f',Tc))
   
    %----------------------------------------------------------------------
    if(tipo==1)
    % Interpolazione ideale
    xr_i = zeros(1,length(t));
    for k = 1:length(tsample)
        xr_i = xr_i + xc(tsample(k))*sinc((t-t(tsample(k)))/Tc);
    end
     subplot(r,c,3),plot(t,xr_i,t,x), title(sprintf('Segnale ricostruito idealmente xr_i, con T_c=%.2f',Tc))
    fprintf('Energia dell''errore di ricostruzione con interpolatore ideale e T_c=%.3f: %.3f\n',...
        Tc, myIntegrale(abs(x-xr_i).^2,dt))
    end
    %----------------------------------------------------------------------
    if(tipo==2)
    % ZOH interpolazione col mantenimento
    x_ZOH = zeros(1,length(t));
    for k = 1:length(tsample)-1%perchè se no avrebbe dato errore
        %mantenere il campione finchè non trovo il successivo
        x_ZOH(tsample(k):tsample(k+1)-1) = xc(tsample(k));
    end
    x_ZOH(tsample(end):end) = xc(tsample(end));
    subplot(r,c,3), plot(t,x_ZOH,t,x), title(sprintf('Segnale ricostruito mediante interpolazione ZOH xZOH, con T_c=%.2f',Tc))
    fprintf('Energia dell''errore di ricostruzione mediante interpolazione ZOH e T_c=%.3f: %.3f\n',...
        Tc, myIntegrale(abs(x-x_ZOH).^2,dt))
    %serve per i grafici
    end
    %----------------------------------------------------------------------
    if(tipo==3)
     % Interpolazione lineare
    x_L = zeros(1,length(t));
    for k = 1:length(tsample)
        x_L = x_L + xc(tsample(k))*tri((t-t(tsample(k)))/Tc);
    end
     subplot(r,c,3),plot(t,x_L,t,x), title(sprintf('Segnale ricostruito linearmente x_L, con T_c=%.2f',Tc))
    fprintf('Energia dell''errore di ricostruzione con interpolatore lineare e T_c=%.3f: %.3f\n',...
        Tc, myIntegrale(abs(x-x_L).^2,dt))
    end
    count=count+1;
end
end

