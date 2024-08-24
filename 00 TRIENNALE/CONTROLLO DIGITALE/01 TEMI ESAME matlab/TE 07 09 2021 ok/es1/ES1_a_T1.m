close all
clear all
clc
%-------------------------------------------------------------------------
% inserisco il sistema

num= 100*[100 1];
den= conv([10 1], [0.1 1]);
G=tf(num,den)
%-------------------------------------------------------------------------
% calcolo zeri, poli
guadagno = dcgain(G)
[z,p,k]=zpkdata(G,'v')

Tv=0.1  % la costante di tempo piu veloce è 0.1
%-------------------------------------------------------------------------
% calcolo fdt ZOH
Tc = 0.001 % dalle specifiche
Gzoh =tf (1,[0.5*Tc 1]) %approssimazione
%-------------------------------------------------------------------------
% sottosistema analogico
Ga = G*Gzoh
%-------------------------------------------------------------------------
% progetto il controllore su Ga

% apro sisotool da command window: sisotool(Ga)

% DEVO RISPETTARE LE SPECIFICHE

% 1. l'errore a regime a fronte di un seto point a scalino = 0
% controllo se è presente un integratore nella funzione Ga, no
% lo aggiungo quindi nel controllore 
% dopo averlo aggiunto osservo che ho PM=2,93, basso

% 2. comportamento simil primo ordine
% per far ciò devo avere PM>75°

% 3. T=1s = 5* cost_tempo 
    % polo =-1/cost tempo =-5
    % wt>5
% 4. sovraelongazione massima 5%
    % dal grafico 5% corrisponde a PM>75°

% 5. disturbo a w = 100 =-35dB

% REALIZZAZIONE
    % Ga non presenta un integratore, lo aggiungo a C
    % adesso PM= 2,93 gradi
    % quindi aggiungo uno zero in banda per aumentarlo
    % lo aggiungo in W=10
    % correggo il guadagno per avere wt = 10
    % in w=100 ora è a poco meno di -20Db, il disturbo non si attenua
    % abbastanza
    % quindi aggiungo un polo tra wt e w=100 per abbassare la pendenza del
    % modulo
    % ne aggiungo ancora uno per scendere più velocemente
   % correggo il guadagno per rispettare il margine di fase
   % ora in w=100 ho -35dB

   %esporto il controllore
   % lo converto digitando in command window C=tf(C)
    % lo salvo

    load C_file C

    %lo discretizzo
    Cd =c2d(C,Tc,'tustin')

    %apro simulink e verifico che rispetti le caratteristiche nel tempo

 % in seguito a un malfunzionamento ho un disturbo a w=3000

%il Tc dato è di 0.001




