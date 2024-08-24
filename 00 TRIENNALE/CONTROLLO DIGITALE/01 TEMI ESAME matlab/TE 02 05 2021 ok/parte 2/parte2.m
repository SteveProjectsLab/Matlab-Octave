close all
clear all

clc

Tc = 0.1;

Gzas = tf( 10, conv([1 -0.3], [1 -0.9]),Tc);

% devo passare da Gcl
%-------------------------------------------------------
% avere errore a regime nullo = guadagno Gcl =1
 z =tf('z', Tc);

Gcl = 1/z^2;

Guadagno = dcgain (Gcl) % deve essere 1 

Gcl = 1/Guadagno *Gcl % così sono sicur


%-------------------------------------------------------
% tempo di inseguimento finito nullo 1/z^p con p= 2 (gr rel Gzas che è = 2)

C= minreal((1/Gzas)*(Gcl/(1-Gcl)))

% se fosse uscito gr N > gr D avrei

