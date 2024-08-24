% MOLARI STEFANO 727197
close all
clear all
clc

% inserisco il sistema

num =1000*[10 1];
den=conv([100 1],[0.1 1]);
G=tf(num,den)
bode(G)
% calcolo zeri, poli, costante di trasferimento
[z,p,k]=zpkdata(G)

% calcolo il guadagno
guadagno = dcgain(G)

% inserisco ZOH
Tc=0.001
Gzoh=tf(1,[0,5*Tc 1])

% calcolo sottosistema analogico
Ga=G*Gzoh

% adesso che ho Ga posso aprire sisotool e progettare il controllore

% le specifiche da rispettare sono:

%1. errore a regime a seguito di un set point a scalino nullo
    % per far cio controllo se il sistema contenga già un integratore, non
    % lo contiene quindi dovrò aggiungerlo nel controllore
%2. % il sistema controllato deve avere un comportamento simile a un
    %sistema del primo ordine e deve arrivare a regime in 1s
  
    % per fare ciò dovrò avere PM>x75
    % inoltre so che T= 1 =5* cost tempo
    % cost tempo = 1/5 s
    % polo = -1/cost tempo = -5
    % wt>5

%3  % un disturbo a w=100 deve essere attenuato di almeno 30 dB

% da command window eseguo il comando Sisotool(Ga)
    % aggiungo manualmente un integratore 
    % il margine di fase è troppo basso, aggiungo uno zero epr compensare
    % il primo polo
    % il modulo è troppo piatto, aumento la pendenza inserendo un polo al
    % primo zero
    % per aumentare il margine di fase aggiungo uno zero per compensare il
    % prossimo polo
    % regolo a mano il guadagno per rispettare wr>5
    % a w=100 ho trroppa poca attenuazione
    % aggiungo così un polo tra wc e w=100 e aggiusto di poco il guadagno
    % l'uscita rispetta così le specifiche e il controllore è causale
    % grNUM <= grDEN
    
% esporto il controllore appena creato
% lo converto da formato zpk a formato tf
% da command window scrivo C=tf(C)
% lo salvo
% da commmand window scrivo save C_file C

load C_file % carico il controllore
%discretizzo il controllore con il metodo di tustin
Cd=c2d(C,Tc,'tustin')

% poi apro simulink e verifico che il sistema retroazionato,
% con C e G in anello aperto ( ZOH e campionatore lo aggiunge matlab)
% risopetti le specifiche richieste nel tempo

% digito da command window simulink per avviarlo

% utilizzo una discrete transfer function per Cd
% utilizzo una transfer function per il sistema

% osservo l'uscita, arriva in meno di un secondo a regime, non ha
% sovraelongazioni e si comporta come un sistema del primo ordine.
% la variabile di controllo sembra fisicamente realizzabile.

% indicare se il Tc indicato è compatibile con le caratteristiche del
% sistema

% la specifica frequenziale più in alta frequenza è w=100
% wc1=5*w=500
%Tc1 =2pi/wc1
Tc1=(2*pi/500)%0.0126
% tc1 > Tc dato
% quindi il tempo di campionamento dato è compatibile.