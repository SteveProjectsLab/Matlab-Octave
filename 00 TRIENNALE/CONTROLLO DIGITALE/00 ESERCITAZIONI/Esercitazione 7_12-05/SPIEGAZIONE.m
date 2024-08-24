clear 
close all
clc

%%
%ESERCIZIO TEMA ESAME:  progetta controlore con metodo della
%discretizzazione

%%
%Definisco il sistema G1

num= 1;
den= conv([1 1], [1 1]);

sys_c=tf(num, den);

%%
%Calcolo Tcamp= 0.1*costante di tempo + veloce
%Qui costante di tempo più veloce è 1

Tc=0.1;

%%
%Metodo Bode: disegno diagramma e vedo dove si attenua di 40 dB

%Ulteriori Metodi basati su specifiche

%%
%Metodo 3: wc=10*w_taglio

%Calcolo w_taglio con PO(sovraelongazione massima) e Ts2 ( tempo assestamento 2%)

PO=0.1; %(=10%) -> DA grafico = smorzamento = 0.6 [del sistema retroazionato]
smorzamento=0.6; %(di 1/1+L)

%So che margine di fase della funzione ad anello PM è:
PM= 100*smorzamento; %(di L)
PM= 60 ;%(dovrebbe essere >= 60)

%Per Tempo Assestamento Ts2 = 4/(smorzamento * w_n)

Ts2= 2/3;

w_n = 10; %(dovrebbe essere >= 10) (di 1/1+L)

%So che w_n di 1/1+L è circa = w_taglio di L

w_taglio= w_n;

wc= 10*w_taglio;
Tc=2*PI/wc;

%%
%Metodo 4: wc= 5*wn (con wn che è la specifica più ad alta frequenza)
% è la pulsazione del disturbo
wn=100;
wc= 5*wn;
Tc=2*PI/wc; % SCELGO QUESTO PERCHÈ È IL PIù VELOCE!

%%
T_campionamento= 2*PI/500;

%%

% ANALISI SPECIFICHE:

% s1: PM>= 60
% 
% s2= w_taglio >= 10;
% 
% s3= |L(100j)| < -25dB   %Per impatto del disturbo !
% 
% s4= e_infinito= 0.1 con riferimento a scalino
% 
%     e_infinito= 1/|L(0)+1| , in continua
%     
%     Quindi L(0) >9

%%


% Sottosistema Analogico
% 
% Ga= Gzoh * Gs    =SISTEMA SU CUI PROGETTARE CONTROLLORE
% 
% Con Gzoh= 1/ (0.5*T_camionamento +1)


%%

%Poi di progetta su SISITOOL !

%Si parte dalle specifiche a BASSA FREQUENZA e poi si va in alta
%MODIFICO C, su sisotool

%1) ERRORE A REGIME: devo avere L(0) >9

    C=1, non rispetta la specifica, quindi lo metto a 10
    
    Ma, ora il PM risulta 36 e noi vogliamo >60
    
2) MARIGINE FASE PM > 60

    Metto uno zero in banda, vicino al 1° polo più a sx
    
    Metto Zero su BODE
    
    Così PM > 90
    
    Anche w_taglio viene 9.93, ch eanche se è < 10 permette di rispettare specifica s2,
    ovvero il tempo di assestamento
    Perchè: ho aumentato lo smorzamneto e velocizzato la risposta
    
3) Per la specifica s3 devo essere a -25dB in 100

    Guardo dul grafico di bode a quanto sono in 100
    
    Non sono a -25dB -> METTO UN POLO, tra w_taglio a wn=100
    
    
    