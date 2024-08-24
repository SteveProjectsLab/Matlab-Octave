function  x_lineare = Campionamento_InterpolazioneLineare(x,estremo_inf,passo,estremo_sup,t,f, numero_figure)
%CAMPIONAMENTO_INTERPOLAZIONELINEARE Summary of this function goes here
%   Detailed explanation goes here
dt=t(2)-t(1);
df=f(2)-f(1);
count=numero_figure;

figure(count),set(count, 'WindowStyle', 'docked');count=count+1;
plot(t,x), title('x')

X = T_Fourier(x,t,f); %calcolo la TDF
figure(count),set(count, 'WindowStyle', 'docked');count=count+1;
plot(f,abs(X)), title('X')

origine = ceil(length(t)/2);
%per scoprire dove è il t=0

count=3;%numero di partenza della prossima figura
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
    
    %INTERPOLAZIONE LINEARE: x_ideale= x_camp*tri(t/T_campionam.)
    
    x_lineare=zeros(1, length(t));
    
    for k=1:length(t_sample)
        
        x_lineare= x_lineare + x_campionato(t_sample(k))*tri((t-t(t_sample(k)))/T_campionamento);
    end
    
    subplot(r,c,3),plot(t, x_lineare, 'b', t, x,'black'),title (sprintf('Segnale ricostruito linearmente, con T_campionamento=%.2f ', T_campionamento))
     
    fprintf('Energia dell''errore di ricostruizione con interpolazione lineare e Tc= %.3f: %.3f\n',T_campionamento, integrale(abs(x-x_lineare).^2,dt))
   
    count=count+1;
    %serve per creare una nuova finestra in cui visualizzare i grafici
end
end



