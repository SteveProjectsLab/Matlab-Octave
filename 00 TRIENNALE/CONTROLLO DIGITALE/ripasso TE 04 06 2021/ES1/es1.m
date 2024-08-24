%           MOLARI STEFANO 727197 08/06/2022
% ora inizio 21:20

close all
clear all
clc

% inserisco il sistema
Tc=0.001

num=100*[100 1]
den=conv([10 1],[0.1 1])
G=tf(num,den)

% G =
%  
%    10000 s + 100
%   ----------------
%   s^2 + 10.1 s + 1
  
%calcolo il guadagno
guadagno_G=dcgain(G)

% calcolo zeri, poli, costante di trasferimento
[z,p,k]= zpkdata(G,'v')

% inserico ZOH, utilizzando approssimazione di padé
Gzoh= tf(1,[0.5*Tc 1])

% Gzoh =
%  
%        1
%   ------------
%   0.0005 s + 1

% inserisco il sottosistema analogico
Ga=G*Gzoh

% Ga =
%  
%              10000 s + 100
%   -----------------------------------
%   0.0005 s^3 + 1.005 s^2 + 10.1 s + 1

% adesso progetto il controllore
% devo rispettare le seguenti specifiche nel tempo:
    % 1. L'errore a regime a fronte di un riferimento a scalino deve nullo
        % per far ciò devo vedere se G possiede già un integratore, in caso
        % contrario lo aggiungerò a C
    % 2. Il sistema retroazionato devo avere un comportamente 
    %       assimilabile a un sistema del primo ordine.
        % per fare ciò devo avere PM>75°
    % 3. Il sistema deve raggiungere il valore di regime in un tempo T=1s
         % so che T=1s=5/cost_tempo ->cost_tempo= 1/5
         % polo=-1/cost tempo -> w>5
         
    % 4. Sovraelong. massima percentuale pari al 5% su un rif. a scalino
         % per fare ciò devo guardare il grafico messo a disposizione 
         % nel materiale esame
         % sovr 5% corrisponde a smorz=0.75
         % so che PM=100*smorz -> PM>75
    % 5. Un disturbo sulla linea di retroazione che arriva a pulsazione 
    %   w = 100 deve essere attenuato almeno di 35dB
        % dal diagramma del modulo di bode vedrò se è così, altrimenti
        % agirò di conseguenza

% per progettare i lcontrollore continuo digito su command window:
% sisotool(Ga)

% inserisco manualmente un integratore, dato che non è presente in G
% il margine di fase è troppo basso
% aggiungo uno zero in banda, per migliorare il margine di fase
% aggiusto il guadagno, e per ottenere un'attenuazione adeguata a w=100,
% inserisco un polo tra wt e w=100

% ottengo PM78,9 e wt=6,97rad/s

%esporto il controllore

% C =
% C =
%  
%   0.01783 s^2 + 0.1894 s + 0.01914
%   --------------------------------
%      s^3 + 34.33 s^2 + 0.3627 s

% lo converto in formato tf 
% digidando su command window:
% C=tf(C)
% sempre da console lo salvo in un file
% save C_file C

% lo carico
load C_file C

% lo discretizzo

Cd= c2d(C,Tc,'tustin')


% apro simulink e verifico che rispetti le specifiche nel tempo
% da command window digito:
% simulink





