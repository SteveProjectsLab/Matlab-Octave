clear 
close all
clc

%%
%Definisco il 1° sistema G1
num1 = 10;

den1_1= [1 1];
den1_2= [1/100 1];

den1= conv(den1_1, den1_2);

sys_1= tf(num1, den1);

%%
%Definisco il 2° sistema G2
num2 = 10;

den2_1= [1 10];
den2_2= [1 100];

den2= conv(den2_1, den2_2);

sys_2= tf(num2, den2);


%%
%Definisco G3= G1*G2

sys_3= sys_1*sys_2;

%Zero, Poli e Costante
[z,p,k] = zpkdata(sys_3) ;

%Guadagno
g3= dcgain (sys_3); 

%Bode
figure
bode(sys_3)

%Margini Guadagno e Fase
[Gm,Pm,Wcg,Wcp] = margin(sys_3);

%Nyquist
figure
nyquist(sys_3);

%%
%Uscita di G3 a fronte del transitorio esaurito, voglioc he insegua lo
%scalino con essore nullo
%-> ingresso=scalino
%-> uscita= ampiezza scalino

%-> porto guadagno di G3 a 1

%( in anello chiuso dovrei usare l'integratore, a patto di mantenere l aSTABILITÀ)


%nel diagramma di Nyquist, in -1 c'è il punto critico
%-> la stabilità dipendeva dal numero di giri del diagramma intorno a -1


%%
%CRITERIO DI NYQUIST E DI BODE

%CRITERIO DI BODE: funziona solo per sistemi che sono stabili in anello
%                   aperto

%CRITERIO DI NYQUIST: vale anche per sistemi INSTABILI in anello aperto
%                   ( ovvero per sistemi con poli a parte reale > 0)



%%
%SOLUZIONE ESERCIZI "per casa"

%1. Quali sistemi sono stabili in Anello Aperto

%-> lo sono 1 e 2, perrchè hanno poli a parte reale negativa 
%PER ANELLO APERTO guardo solo i POLI!!


%2. Quali sistemi sono stabili in Anello Chiuso
%(Partendo dal sistema in anello aperto)

%-> lo è 1, perchè è stabile se PM > 0 e posso applicare il criterio di Bode
%-> non posso dirlo per 3, perchè NON posso applicare il criterio di Bode
%(non è stabile in anello aperto)
%   Per 3 dovrei usare Nyquist






