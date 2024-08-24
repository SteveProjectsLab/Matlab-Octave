clear all
A=[-3 10;0 -8];
B=[1 1]';
C=[1 1];
G= [1 0;0 3];
Rw=[0.01 0;0 0.01];
Rv=0.01;
%è stabile questo sistema? è triangolare superiore, gli autovalori stanno
%sulla diagonale, sono a parte reale negativa, quindi il sistema è stabile


% punto A
% le ipotesi necessarie per l'applicazione del filtro di Kalman che
% possimao testare con Matlab
rO=rank(obsv(A,C)) % ha rango 2 come il n° di variabili di stato
rG=rank(ctrb(A,G)) % ha rango 2 come il n° di variabili di stato
% ok per entrambe le condizioni

% ls rsggiungibilità servirebbe solo con il controllore, ma ora non c'è
% ora calcoliamo il guadagno del filtro di Kalman
[L,P,Eo]=lqe(A,G,C,Rw,Rv)
% A G sistema
% C uscita
% Rw incertezza sistema
% Rv incertezza uscita

% risulta il guadagno di osservazione
% L =    1.3930
%     0.8725

%punto B
% quanto ci mette  questo sistema a ricostruire lo stato?
%(A-LC) ha autovalori:
% Eo =
%   -6.6327 + 1.5790i
%   -6.6327 - 1.5790i
% ha costante di tempo dominante pare a 
% Td=1/6.6327
% quindi raggiungerà l'equilibrio (e=0) in Tr=5*Td
Tr=- 5*1/real(Eo(1)) % =0.7538
% NB non vedremo l'errore a 0 perchè vedremmo comunque l'effetto
% dell'incertezza, avendo però l'incertezza a media nulla, da un certo
% istante in poi l'errore sarà intorno a zero.

% punto C
% la varianza dell'errore di stima la si trova sulla diagonale della
% matrice P, soluzione dell'equazione algebrica di Riccati P
% essendo essa la matrice della covarianza dell'errore di stima,
% trattandosi dello stato x2 troverò la varianza del suo errore di stima
% all'elemento P(2,2) della matrice => 0.0051

% la soluzione dell'eq alg. di Riccati per il filtro di Kalam, in realtà è
% un eq di RIccati duale, ci da un'informazione subito utilizzabile 
% (a differenza del controllo ottimo): quanto
% bene o male riusciamo a stimare le diverse componenti dello stato.

% possiamo notare che in uqesto caso la varianza dell'errore di stima
% sullos tato x2 è la metà della varianza dell'errore di stima sullo stato
% x1, possimao dire che si muoverà più raccolto l'errore vicino allo 0

%Punto D

Xo=[3 0];
ueq=3;
% NB IN SIMULINK EMTTI CONDIZIONE INIZIALE A INTEGRATORE SISTEMA 
% NB CONSIZIONE INIZIALE OSSERVATORE NULLA