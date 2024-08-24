clear all
%il mio sistema (nella realtà in cui immagino v e w processi stocastici)
% diventa 
% dx/dx=Ax+Bu+GW ( G ha le stesse dimensioni di A)
% y=Cx+v

% all'inizio del corso abbiamo detto che y è l'effetto del sistema
% sull'ambiente circostante, così noi possiamo osservarlo
% adesso l'osservazione di y impone questo rumore
% quindi Cx è la temperatura reale
% Cx+V è il valore che mi restituisce il sensore

A=[0 2;-4.5 -10];
B=[1 1]';
C=[1 1];

G=eye(2);

% immaginiamo che il nostr sistema abbiam una componente non lineare a
% media nulla che decidiamo di trascurare
% trascurare ciò mi crea un'inecrtezza di certo tipo.
%tutta la componente che impatta su x1, va messa in w1, analogamente per x2

Rw=[0 0; 0 0.01];
Rv= 0.01;

% verifico l'osservabilità di (A,C) e raggiungibilità di (A,G)
% che sono due condizioni per il calcolo di L
% è un osservatore dellos tato, nel caso milgiore possibile , ovvero che il
% sist sia lineare, la misura è perfetta, io sia in grado di ricostruire lo
% stato
% l'osservabilità si AC significa che almeno nel caso ideale puoi
% strutturalmente risolvere il sistema
% la raggiungibilità serve a dire che w ha effettivamente un impatto sullo
% stato
% in questi caso devono avere rango 2
% da teoria non sono le uniche condizioni, stiamo assumendo che le
% condizioni su v e W siano soddisfatte.
% (scrivi a mano le ipotesi quali sono all'esame)

rO=rank(obsv(A,C))%=2
rG=rank(ctrb(A,G))%=2

% entrambe hanno rango massimo =>x posso applicare kalman, pensando che L esista

% il comando per calcolare la L è il comando lqe
[L,P,E]=lqe(A,G,C,Rw,Rv)
[L2,P2,E2]=lqe(A,G,C,Rw*10,Rv)
% gli autovalori ci dicono quanto ci mette l'errore sullo stato a
% raggiungere il valore di regime e quindi vediamo che A-LC ha un
% autovalore dominante in -1
% E =   -1.1552
%    -9.5218
% qualunque controllore  che richieda un autovalore dominante più veloce di
% -1,
% si scontra con il fatto che l'osservazione dello stato sarà più lenta,
% quindi alla fine la dinamica dominante non potrà essere migliore da
% quella fissata dall'autovalore in -1
% P è più interessante di l, perchè si può dimostrare che P è la matrice
% delle covarianze degli errori di stima
% facendo un parallelismo con gli algoritmi di ottimizzazione, è l'ottimo
% della funzione obiettivo
% l'obiettivo è quello di minimizzare la variante dell'errore
% quelli sulla diagonale ho le varianze pure
% sono le migliori varianze posisbili per il sistema che abbiamo che
% calcola il filtro di kalman a fronte di quella L
% P =
%     0.0018    0.0001
%     0.0001    0.0048

