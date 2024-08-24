close all
clear all
clc

Tc=0.1
% inserisco il sistema ZAS
num=10;
den=conv([1 -0.3],[1 -0.9])
Gzas=tf(num,den,Tc)

% calcolo Gcl


% 2. Il tempo di inseguimento del setpoint sia finito e minimo.
    % per fare ciò
        z=tf('z',Tc)
Gcl = 1/z^2
    

% 1. L errore a regime a fronte di un riferimento a scalino 
%      deve essere pari a 0.
    % per far ciè devo far si che guadagno in 1 sia unitario Gcl(1)=1
guadagno =dcgain(Gcl)%vale 1 ok


% creo il contrrollore
C=minreal((1/Gzas)*(Gcl/(1-Gcl)))

% apro simulink

% i blocchi che conterranno C e Gzas saranno Transfer function

% osservando la variabile di controllo:
% il suo valore massimo è 0.1
% il suo valore minimom è -0.02

% osservando l'uscita:
% il suo valore massimo è 1
% il suo valore minimo è 0
% ci impiega 0.2 s per arrivare a regime, (2*Tc)