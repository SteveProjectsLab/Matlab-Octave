clear
close all
clc


dt=0.01;
t=-10:dt:10;
dtau=dt;
tau=-15:dtau:15;  %di quanto traslo la funzione -> è un nuovo set di valori


%NB: conj opera la coniugazione
%%
%ES.1

%punto a) calcolo autocorrelazione rect

autocorr_rect= zeros(1, length(tau)); %dipende da tau!!

for k=1:length(tau)
    
   autocorr_rect(k)= integrale(conj(rect(t)).*rect(t+tau(k)), dt); 
   %Con tau(k) scorro tutti i valori di tau da -15 a 15
    
end

plot( tau ,autocorr_rect), title('AutoCorrelazione Rect')

%*OPPURE -> uso direttamente tau per scorrere, ma devo usare count perchè
%altrimenti avrei un indice di vettore negativo

%count=1
%for k=tau

%autocorr_rect(count)= integrale(conj(rect(t)).*rect(t+k), dt);
%count=count+1;
    
%end


%punto b) calcolo cross_correlazione rect e tri

cross_corr=zeros(1, length(tau));

%x=rect(t)
%y=tri(t)

for k=1:length(tau)
   cross_corr(k)= integrale( conj(rect(t)).*tri(t+tau(k)), dt);
end

figure
plot(tau , cross_corr), title( 'CrossCorrelazione rect e tri' )



%correlazione segnale immaginario
cross_corr_immag=zeros(1, length(tau));
auto_corr_p= zeros(1, length(tau));

%x=rect(t)
%y=j*tri(t+1)
%f= rect(t-1/2) - rect(t-3/2)

for k=1:length(tau)
   cross_corr_immag(k)= integrale( conj(rect(t)).*(1i*tri(t+1+tau(k))), dt);
   auto_corr_p(k)=integrale( conj(rect(t-1/2) - rect(t-3/2)) .* (rect(t-1/2+tau(k)) - rect(t-3/2+tau(k))), dt);
   %NB: l'autocorrelazione di due rect traslati è uguale a due volte
   %l'autocorrelazione del rect, meno le due autocorrelazioni 
   %Esce quindi un triangolo grande a cui sottraggo due triangoli traslati
end

figure
plot(tau ,real( cross_corr_immag),'b')
hold on
plot(tau ,imag( cross_corr_immag), 'g--'), title( 'CrossCorrelazione rect e j*tri' )

figure
plot(tau ,auto_corr_p ,'black--')
hold on


%%
%ES.2 segnali periodici

%punto a)
%funzione p periodica p(t − 2k),per k da - a + infinito

T=2;
x=zeros(1, length(t));  

for k= min(t)/T:max(t)/T
    
    x=x+rect(t-1/2+k*T)-rect(t-3/2+k*T);
    %così facendo costruisco tutte le funzioni
    
end

plot (t, x)

cross_corr_circ_xy=zeros(1, length(tau));

for k=1:length(tau)
    
   cross_corr_circ_xy(k)= integrale(rect(t/T).*conj(x).*sin(pi*(t+tau(k))), dt)/T; 
   %rect(t/T)è fatto per finestrare solo un periodo
   % /T è dato dalla definizione della correlazione
    
end

figure

plot(tau, cross_corr_circ_xy, 'black')


%punto B)

autocorr_circ= zeros(1, length(tau));

for k=1:length(tau)
    
   x_tau=zeros(1, length(t));
    for r= floor(min(t+tau(k))/T):ceil( max(t+tau(k))/T )%voglio costruire il segnale traslato x
        %floor() mi restituisce l'intero precedente, perchè min(t+tau(k))/T potrebbe
        %restituire un numero decimale
        
        %ceil() mi restituisce l'intero successivo
        
        x_tau= x_tau + rect(t-1/2 +tau(k) - r*T) - rect(t-3/2+tau(k) - r*T);
        %r*T= traslazione del periodo
    end
    autocorr_circ(k)= integrale(rect(t/T).*conj(x).*x_tau, dt)/T;
    %con rect(t/T) riquadro solo un periodo
end   

%NB: con floor(min(t+tau(k))/T):ceil( max(t+tau(k))/T ) mi calcolo il
%numero esatto di periodi che occorrono!;
% se non voglio calcolare il numero esatto -> metto numeri molto grandi

figure  
plot( tau, autocorr_circ, 'black --'), title('Autocorrelazione segnale periodico x')



%%
%ES.3 CONVOLUZIONE

%uno dei due segnali è prima ribaltato e poi traslato
%la traslazione è in t e l'integrale è in dtau.

autoconvoulzione_rect = zeros(1, length(t));  % auto conv è definita su t

for k= 1:length(t)
   
    autoconvoulzione_rect(k)=integrale(rect(tau).*rect(t(k)-tau), dtau);
end


figure 
plot( t , autoconvoulzione_rect), title('Autoconvoluzione rect')





