close all
clear all
clc


Tc=0.1

% inserisco il sistema
num=5;
den=conv([1 -0.1],[1 -0.4]);
Gzas=tf(num,den,Tc)

% Gzas =
%  
%           5
%   ------------------
%   z^2 - 0.5 z + 0.04

% il suo grado relativo è 2

% devo progettare un controllore che rispetit le specifiche:
%1. L’errore a regime a fronte di un riferimento a 
%   scalino deve essere pari a 0.
        % per fare ciò devo avere guadagno unitario in Gcl
        
% il tempo di inseguimento del setpoint sia finito e minimo
    % per fare ciò devo far si che
    % Gcl= 1/z^P con P = grado relativo Gzas

z=tf('z',Tc);
Gcl=1/z^2 % dato che il grado relativo di Gzas è 2

guadagno = dcgain(Gcl)

% il guadagno è unitario

% ho rispettato entrambe le specifiche

% ora verifico su simulink

C= minreal((1/Gzas)*((Gcl)/(1-Gcl)))

% C =
%  
%   0.2 z^2 - 0.1 z + 0.008
%   -----------------------
%           z^2 - 1
%  
% Sample time: 0.1 seconds
% Discrete-time transfer function.

% ho utilizzato il comando minreal per eseguire le possibili
% semplificazioni

% posso notare come il controllore ritardi l'uscita di 2*Tc =0.2s
% infatti il controllore introduce un ritardo di 2 Tc

