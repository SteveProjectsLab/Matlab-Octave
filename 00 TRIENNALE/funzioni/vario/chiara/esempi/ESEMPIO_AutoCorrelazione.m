clear
close all
clc


dt=0.01;
t=-10:dt:10;
dtau=dt;
tau=-15:dtau:15;  %di quanto traslo la funzione -> è un nuovo set di valori

%CALCOLO AutoCorrelazione di x=rect(t)

autocorr_rect= zeros(1, length(tau)); %dipende da tau!!

for k=1:length(tau)
    
   autocorr_rect(k)= integrale(conj(rect(t)).*rect(t+tau(k)), dt); 
   %Con tau(k) scorro tutti i valori di tau da -15 a 15
    
end

plot( tau ,autocorr_rect), title('AutoCorrelazione Rect')
