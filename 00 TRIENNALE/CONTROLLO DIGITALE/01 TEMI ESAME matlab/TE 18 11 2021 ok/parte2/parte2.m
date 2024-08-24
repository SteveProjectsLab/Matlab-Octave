clear all
close all
clc

% inserisco Gzas(z)
Tc=0.1
num= 10;
den =conv([1 -0.3],[1 -0.9]);
Gzas=tf(num,den,Tc)

%progetto C(z) in modo che
% L'errore a regime a fronte di un riferimento a scalino deve essere nullo
% Il tempo di inseguimento del setpoint sia finito e minimo.

z=tf('z',Tc);
P=2 % grado relativo Gzas
Gcl=1/z^P;

% in questo modo garantisco il tempo di inseguimento

% per avere errore nullo devo far si di avere guadagno unitario

% contrrollo che sia unitario, in caso contrario lo cambio
guadagno = dcgain(Gcl) % effettivamente vale 1

% implemento il controllore
C=minreal((1/Gzas)*(Gcl/(1-Gcl)));

% simulo utilizzando simulink

