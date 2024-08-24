clear
close all
clc

dt=0.01;
t=-10:dt:10;

df=0.01;
f=-15:df:15;

%CAMPIONAMENTO

x= 8*sinc(t/2);
plot(t, x), title('Segnale x1')

X= T_Fourier(x, t, f);
figure
plot(f, abs(X)), title('Segnale X1(= Trasformata Fourier)')

origine= ceil(length(t)/2);
%per scoprire dove è il t=0

for n=10:10:50
    
    T_campionamento= n*dt;
    t_sample= mod(origine, n):n:length(t);
    %mod(origine, n) resittuisce il resto della divisione -> shift per far
    %sì di finire nell'origine e di prendere il segnale in t=0 !!
    
    x_campionato= zeros(1, length(t));
    x_campionato(t_sample)= x(t_sample);
    %definisco il segnale campionato attraverso i valori del segnale
    %originale in quegli istanti
    
    figure
    stem(t, x_campionato), title (sprintf('Segnale campionato, con T_campionamento=%.2f ', T_campionamento))
    
    %CALCOLO TRASFORMATA FOURIER
    Xc= T_Fourier(x_campionato, t, f);
    figure
    plot(f, abs(Xc)), title (sprintf('Spettro segnale campionato, con T_campionamento=%.2f ', T_campionamento))
    
    %INTERPOLAZIONE IDEALE
    
    %Voglio finestrare nelle frequenze i valori della trasformata da -f_camp/2 a +f_camp/2
    %=convoluzione nei tempi con sinc(t/T_campionam.)
    
    x_ricostruito_InterpolIdeale=zeros(1, length(t));
    
    for k=1:length(t_sample)
        
        x_ricostruito_InterpolIdeale= x_ricostruito_InterpolIdeale + x_campionato(t_sample(k))*sinc((t-t(t_sample(k)))/T_campionamento);
        %t_sample= vettore con indici istanti temporali su cui ho
        %effettuato il campionamento
        
        %ad ogni for sommo al segnale un sinc la cui ampiezz è data dal
        %valore originale in quell'istante temporale
        
        %sinc ((t- traslazione)/T_campionamento);
        %Traslazione= t(t_sample(k));
        
    end
    figure 
    plot(t, x_ricostruito_InterpolIdeale, t, x),title (sprintf('Segnale ricostruito idealmente, con T_campionamento=%.2f ', T_campionamento))
     
    fprintf('Energia dell''errore di ricostruizione con interpolazione ideale e Tc= %.3f: %.3f\n',T_campionamento, integrale(abs(x-x_ricostruito_InterpolIdeale).^2,dt))
   
    
    %ZOH interpolazione -> non ideale
    %=MANTENIMENTO
    
    x_ZOH= zeros(1, length(t));
    
    %ogni volta che trovo il campione del segnale campionato lo mantengo
    %fino al successivo
    
    for k= 1: length(t_sample)-1 %perchè non devo sforare
       
        x_ZOH(t_sample(k):t_sample(k+1)-1)= x_campionato(t_sample(k));
        %mantengo il segnale campionato per i primi valori
        
    end
    
    x_ZOH(t_sample(end):end)= x_campionato(t_sample(end));
    %per settare gli ultimi valori : non li faccio nel for perchè sforerei
    
    figure
    plot(t, x_ZOH, t, x), title('Segnale ricostruito con interpolazione ZOH')
    fprintf('Energia dell''errore di ricostruizione con interpolazione ZOH e Tc= %.3f: %.3f\n',T_campionamento, integrale(abs(x-x_ZOH).^2,dt))
end





