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
%Calcolo la CrossCorrelazioneCircolare tra:
%x=rect(t-1/2)-rect(t-3/2) e y= sin(pi*t)

cross_corr_circ_xy=zeros(1, length(tau));

for k=1:length(tau)
    
   cross_corr_circ_xy(k)= (1/T)*integrale(rect(t/T).*conj(x).*sin(pi*(t+tau(k))), dt); 
   %rect(t/T)è fatto per finestrare solo un periodo
   % (1/T) è dato dalla definizione della correlazione
    
end

figure

plot(tau, cross_corr_circ_xy, 'black'), title('Cross Correlazione')

