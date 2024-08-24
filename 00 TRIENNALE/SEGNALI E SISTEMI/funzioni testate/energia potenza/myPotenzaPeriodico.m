function y = myPotenzaPeriodico(x,dt,T,t)

%VARIABILI
% x = vettore di valori
% dt = passo
% T = periodo
% t = vettore dei tempi

%COSA FA 
% Potenza = 1/T . energia(segnale periodo)

segnalePeriodo= x.*rect(t/T);
y= myEnergia(segnalePeriodo,dt)/T;

