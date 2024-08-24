clear all
A=[-2 8;0 -10];
B=[2 2]';
C=[1 0];

% PUNTO A1
% testare tutte e sole le ipotesi per la progettazione di un controllo in
% retroazione dello stato in situazione di stato misurabile

% in caso di stato misurabile l'unica condizione è quella di completa
% raggiungibilità
rR=rank(ctrb(A,B)) % ha rango 2 come il n° di variabili di stato
% quindi il sistema è completamente raggiungibile
Q1=eye(2)
R1=eye(1) %oppureR=1 semplicemente
%NB Q R sono matrici di due forme quadratiche, una in x, e quindi Q deve
%avere dimensioni consistente con X e quindi essere una matrice 2x2
%R deve avere dimenisoni consistenti con l'ingresse, ho un ingresso solo
%quindi sarà una 1x1

%CONTROLLO OTTIMO PUNTO A2
%calcolare il guadagno di un controllo ottimo LQ con cifra di merito
%stato-variabile di controllo, con matrici delle forme quadratiche pari
%alle matrici identità

% mi vengono chiesti 3 controllori diversi
%posso calcolare ora
[K1,S1,E1]=lqr(A,B,Q1,R1)
%ottengo:
% K1 =    0.5458    0.4319
% S1 =    0.1755    0.0974     NB in questo caso S non è di alcuna utilità
%         0.0974    0.1186
% E1 =   -4.2736    %autovalori
%         -9.6817
        
% visto che mi viene chiesto il controllore più veloce, senza dover far la
% soluzione, potrò andare a vedere l'autovalore dominante

%PUNTO A3
% calcolare il guadagno di un controllore in retroazione dello stato tale
% che il sistema raggiunga l'equilibrio in un tempo t=10s

%Tr=10s=>Td=2s=> Pd=-1/Td=-0.5 
%l'altro autovalore basta che non sia dominante
%=>scelgo -10 ( anche -1 andava bene, basta che non sia dominante)
E2=[-0.5 -10];% è un controllo classico, quindi avrà gli autovalori che ho specificato io
K2=place(A,B,E2)
%ottengo:
%K2 =   -0.3750   -0.3750

%PUNTO A4
% calcolare il controllo ottimo LQ con cifra di merito stato-variabile di
% controllo, avente peso delle componenti dello stato pari a 10 volte
% quello della variabile di controllo

Q3=eye(2)*10;
R3=1;
% NB Q in realtà sarebbe il peso al quadrato.. non è proprio il peso
[K3,S3,E3]=lqr(A,B,Q3,R3)
%ottengo:
% K3 =    2.4830    1.7218
% S3 =    0.9587    0.2828   % anche qua in questo caso non ci serve
%     0.2828    0.5780
% E3 = -10.2048 + 3.4839i
%  -10.2048 - 3.4839i

% PUNTO B -  quale è il più veloce?
% conoscendo solo gli autovalori, posso dire che il più veloce, con la
% definizione di autovalore dominante che abbiamo detto noi
% quello più a sinistra nel piano complesso darà il più veloce
% perchè invertito e moltiplicato per 5 darà il più veloce

%autovalore dominante del primo è -4, del secondo è -0.5,
%e al momento quello più velòoce ( a sinistra) è il primo
% pur essendo complessi coniugati, quelli del terzo hanno parte reale -10,
%quindi indicativamente il p iù veloce è il terzo.

% PUNTO C - SIMULINK