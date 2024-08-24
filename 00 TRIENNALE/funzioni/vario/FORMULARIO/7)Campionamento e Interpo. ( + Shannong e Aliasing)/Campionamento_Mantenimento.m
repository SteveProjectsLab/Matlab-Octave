function x_ZOH = Campionamento_Mantenimento(x,estremo_inf,passo,estremo_sup,t,f, numero_figure)
%CAMPIONAMENTO_MANTENIMENTO Summary of this function goes here
%   Detailed explanation goes here
dt=t(2)-t(1);
df=f(2)-f(1);
count=numero_figure;%numero di partenza della prossima figura

figure(count),set(count, 'WindowStyle', 'docked'); count=count+1;
plot(t,x), title('x')

X = T_Fourier(x,t,f); %calcolo la TDF
figure(count),set(count, 'WindowStyle', 'docked');count=count+1;
plot(f,abs(X)), title('X')

origine = ceil(length(t)/2);
%per scoprire dove è il t=0

%count=3;%numero di partenza della prossima figura
r=3;    %righe subplot
c=1;    %colonne subplot

for n= estremo_inf:passo:estremo_sup
    figure(count),set(count, 'WindowStyle', 'docked')
    
    T_campionamento= n*dt;
    t_sample= mod(origine, n):n:length(t);
    %mod(origine, n) resituisce il resto della divisione -> shift per far
    %sì di finire nell'origine e di prendere il segnale in t=0 !!
    
    %CALCOLO x_campionato:
    %definisco il segnale campionato attraverso i valori del segnale originale in quegli istanti
    
    x_campionato= zeros(1, length(t));
    x_campionato(t_sample)= x(t_sample);
    
    subplot(r,c,1),stem(t, x_campionato), title (sprintf('Segnale campionato, con T_campionamento=%.2f ', T_campionamento))
    
    %CALCOLO TRASFORMATA FOURIER X_camp
    X_camp= T_Fourier(x_campionato, t, f);
    
    subplot(r,c,2),plot(f, abs(X_camp)), title (sprintf('Spettro segnale campionato, con T_campionamento=%.2f ', T_campionamento))
    
    %MANTENIMENTO: %mantengo il campione finchè non trovo il successivo
    
   x_ZOH= zeros(1, length(t));
    
    %ogni volta che trovo il campione del segnale campionato lo mantengo
    %fino al successivo
    
    for k= 1: length(t_sample)-1 %perchè non devo sforare
       
        x_ZOH(t_sample(k):t_sample(k+1)-1)= x_campionato(t_sample(k));
        %mantengo il segnale campionato per i primi valori
        
    end
    
    x_ZOH(t_sample(end):end)= x_campionato(t_sample(end));
    %per settare gli ultimi valori : non li faccio nel for perchè sforerei
  
    subplot(r,c,3),plot(t, x_ZOH, t, x), title('Segnale ricostruito con interpolazione ZOH')
   
    fprintf('Energia dell''errore di ricostruizione con interpolazione ZOH e Tc= %.3f: %.3f\n',T_campionamento, integrale(abs(x-x_ZOH).^2,dt))
    
    count=count+1;
    %serve per creare una nuova finestra in cui visualizzare i grafici
end
end


