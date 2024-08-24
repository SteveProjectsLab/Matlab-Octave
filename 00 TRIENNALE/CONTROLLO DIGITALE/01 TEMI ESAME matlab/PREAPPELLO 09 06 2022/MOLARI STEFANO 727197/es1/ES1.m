close all
clear all
clc


% inserisco il sistema
num=4*[1 2]
den=conv([2 1],[4 1]);
G=tf(num,den)

% G =
%  
%       4 s + 8
%   ---------------
%   8 s^2 + 6 s + 1

% inserisco lo ZOH utilizzando padé
Tc=0.001;
Gzoh=tf(1,[0.5*Tc 1])

% zoh =
%  
%        1
%   ------------
%   0.0005 s + 1

% calcolo il sottosist4ema analogico

Ga=G*Gzoh

% Ga =
%  
%               4 s + 8
%   -------------------------------
%   0.004 s^3 + 8.003 s^2 + 6 s + 1

% progetto il controllore su Ga


% devo rispettarele specifiche nel tempo:
% 1.L’errore a regime a fronte di un riferimento a scalino 
% deve essere pari a 0
    % per fare ciò devo vedere se è presente un integratore in Ga, in caso
    % non ci sia lo agigungo io
    
% 2.l sistema controllato abbia un comportamento pi`u simile possibile 
% a quello di un sistema del primo ordine che arriva a regime 
% in un tempo T = 0.5 s.
    % per fare ciò devo avere PM>75 gradi, così si comporta come un sistema
    % del primo ordine
    % T=0.5 =5/cost_tempo
    % cost_tempo =0.5/5=1/10
    % polo=-1/cost_tempo
    % quindi wc>10 rad/s

%il disturbo a w=100 deve essere attenuato di almeno 30dB


% utilizzo sisotool digitando in command window:
% sisotool(Ga)

% inserisco manualmente un integratore
% ho un Pm troppo basso
% adesso, partendo da sinistr averso destra,
% compenso i primi due poli con due zeri per migliorare il margine di fase
% compenso lo zero con un polo per aumentare la pendenza del modulo
% aggiungo un polo tra wc e w=100, per far in modo di avere -30dB a w=100
% aggiusto il guadagno

% ottengo PM=72 gradi, avrei dovuto tenerlo maggiore di 75 ma osservando la
% risposta nel tempo si comporta lo stesso come un sistema del primo
% ordine,senz sovraelongazioni
% Wt=10.1 rad/s
% il sistema ottenuto è causale.

% esporto il controllore
% è in formato zpk, lo converto in tf scrivendo in command window:
% C=tf(C)

% C =
  
%   638.1 s^2 + 481 s + 80.98
%   -------------------------
%   s^3 + 31.93 s^2 + 65.71 s

% lo salvo scrivendo in command window:
% save C_file C
load C_file C
% lo discretizzo utilizzando tustin
Cd=c2d(C,Tc,'tustin')

% Cd =
%  
%   0.3142 z^3 - 0.3139 z^2 - 0.3142 z + 0.3139
%   -------------------------------------------
%       z^3 - 2.969 z^2 + 2.937 z - 0.9686
%  
% Sample time: 0.001 seconds
% Discrete-time transfer function.

% apro simulink digiando da command window:
% simulink


% osservo che le specifiche nel tempo vengono rispettate.




