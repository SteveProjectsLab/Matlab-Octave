clear all

A=[0.45 0.55;-1.45 -1.55];
B=[1 1]';
C=[1 0];
%è un problema di controllo ottimo in cui il sitema non è completamente noto.
% sistema non modellizzato bene
% misura uscita rumorosa

% il disturbo w=[w1;w2] (stesse dimensioni di x)
G=eye(2);% matrice che dice se l'incertezza ha un impatto su x1. e x2.
% x1. è influenzata da entrambe le dinamiche che ho trascurato
% x2. è influenzata solo da w2
% costruisco G come costruisco A , solo che al posto di x considero w

Rw=[0 0.05; 0 0.01];    % mat di covarianza incertezza su modello
Rv= 0.01;               % mat di covarianza del sumore su uscita

%leggendo il testo sappiamoa anche che il controllo ottimo va fatto con due
%amtrici identità
Q=eye(2);    % "peso" su x nel controllo LQ
R=1;         % "peso" su u nel controllo LQ

ueq=10;
x0=[3 1]';

% il contrrollo mi chiederà di seguire il punto di equilibrio, per cui
xeq=-inv(A)*B*ueq % calcolo il punto di equilibrio
% risulta xeq=[210, -190]

% già che ci sono calcolo la stabilità
aval=eig(A)%aval=[-0.1,-1]
% ha due autovalori negativi, è asintoticamente stabile, è un nodo stabile
% punto di equilibrio, a fronte di quell'ingresso, è il valore a cui tende
% lo stato a patto che il sistema sia stabile, per i sistemi lineari
% per i sistemi non lineari, la stabilità vale solo per singolo punto id
% equilibrio, possiamo avere punti stabili, instabili, ecc

% è comodo avere a disposizione la stabilità del sistema in anello aperto,
% perchè se vogliamo risolvere il problema per passi, faccio osservatore e
% poi contrrollore, se il sistema è stabile avrò una simulazione hce
% converge, e simulink non mi darà errore, se il sistema è instabile
% simuluink va in overflow e non riesco a vedere la stima dello stato in
% anello aperto.

% suppongo che valgano le ipotesi sulle incertezze v e w
% (sono processi stocastici, gaussiani, bianchi, a media nulla, nuclei di
% covarianza noti (Rw e Rv).
% w e v indipendenti tra di loro, con lo stato iniziale x0(
% le suppongo nel momento in cui uso il blocchettino di kalman di simulink

% ipotesi strutturali che devono valere per la stima dello stato
rO=rank(obsv(A,C))%=2, = ordine sistema, ok
% ipotesi minima che deve esserci e che dice che nel caso migliore in cui
% non hai l'inertezza, il problema di stima dello stato diventa senza
% incertezza
rG=rank(ctrb(A,G))%=2, = ordine sistema, ok
% ci dice che w ha un impatto sullo stato

% ipotesi strutturali per la progettazione del controllo ottimo
% essendo il controllo ottimo in retroazione dello stato, abbiamo bisogno
% che 
rR=rank(ctrb(A,B))%=2, = ordine sistema, ok

% rimane da progettare l'osservatore
[L,Po,Eo]=lqe(A,G,C,Rw,Rv)
% Th di separazione degli autovalori, se abbiamo raggiung e oss di AB
% possimao dividere i due problemi: stima dello stato e progetto del
% controllore
% per stimare lo stato non mi serve teoricamente sapere nulla sulla cifra
% di merito del contrrollore e quinid Q e R non le metto nel filtro di
% kalman
[K,Pc,Ec]=lqr(A,B,Q,R)

% NB copia i risultato su K e L e commentali.
% gli autovalori dell'osservatore e del controllore sono complessi
% coniugati, la parte reale è un po' più alta della parte imamginaria,
% quindi probabilmente saranno abbastanza smorzate le oscillazioni, ma on
% ci stupirebbe vederle.
% in linea di massimo, con le ipotesi che abbiamo fatto, l'osservazione
% dello stato non è troppo vincolante, gli autovalori dominanti restano nel
% controllore

% qua svincolare osservatore e controllore non è facilissimo perchè ho
% oscillazioni
% se avessi avuto una parte reale più grande di un'ordine di grandezza di
% quella immaginaria non avrebbero impattato le oscillaizoni

% Po è la soluz algebrica dell'eq di riccati e la matrice di covarianza
% dell'errore di stima, sula diagonale abbiamo le varianze dell'errore
% rispettivamente su x1 e x2
% var(x1-x1_stimato)=0.0279
% var(x2-x2_stimato)=0.0080

% la media dell'errore è 0, la varianza ci dice quanto la distribuzione
% dei valori dell'errore è concentrata o meno attorno allo zero, e quindi
% per lo stato x2 avremo una serie di errori che sono concentrati
% maggiormente attorno allo 0 rispetto a quanto avviene con x1

% lo stato x2 è stimato meglio rispetto allo stato x1 (secondo la varianza)

% la nostra retroazione deve conservare il punto di equilibrio a fronte di
% ueq=10, quindi u=ueq-K(x_stimato-xeq)

%apriamo simulink