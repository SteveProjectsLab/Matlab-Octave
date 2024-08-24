clear
close all
clc


dt=0.01;
t=-10:dt:10;
dtau=dt;
tau=-15:dtau:15;  %di quanto traslo la funzione -> è un nuovo set di valori


%Costruisco la funzione periodica x= rect(t-1/2)-rect(t-3/2)

T=2;
x=zeros(1, length(t));  


for k= floor(min(t)/T):ceil(max(t)/T)
    
    x=x+rect(t-1/2+k*T)-rect(t-3/2+k*T);
    %così facendo costruisco tutte le funzioni
    
end

plot (t, x)

%%
%Calcolo AutoCorrelazioneCircolare del segnale periodico:
%x=rect(t-1/2)-rect(t-3/2)

autocorr_circ= zeros(1, length(tau));

for k=1:length(tau)
    
   x_tau=zeros(1, length(t));
   
    for r= floor(min(t+tau(k))/T):ceil( max(t+tau(k))/T )
        %voglio costruire il segnale traslato x
        
        x_tau= x_tau + rect(t-1/2 +tau(k) - r*T) - rect(t-3/2+tau(k) - r*T);
        %r*T= traslazione del periodo
    end
    autocorr_circ(k)= (1/T)*integrale(rect(t/T).*conj(x).*x_tau, dt);
    %con rect(t/T) riquadro solo un periodo
end   

%NB: con floor(min(t+tau(k))/T):ceil( max(t+tau(k))/T ) mi calcolo il
%numero esatto di periodi che occorrono!;
% se non voglio calcolare il numero esatto -> metto numeri molto grandi

figure  
plot( tau, autocorr_circ, 'black --'), title('Autocorrelazione segnale periodico x')

