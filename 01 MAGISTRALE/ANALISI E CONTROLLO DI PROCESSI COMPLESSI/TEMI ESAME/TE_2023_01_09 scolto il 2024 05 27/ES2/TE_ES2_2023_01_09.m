clear all
close all
clc

A=[-1 4;0 -5];
B=[1 1]';
C=[1 0];

% PARTE A
% ipotesi necessarie per il progetto del controllore in retroazione dello
% stato
rR=rank(ctrb(A,B)) % deve essere pari a 2
% se venisse detto di progettare il controllore senza l'osservatore lo 
% stato dovrebbe essere misurabile

% in questo caso la misurabilità dello stato era data dal testo
% dobbiamo progettare 3 contrrollori

% contrllo LQ con cifra di merito stato-ingresso con Q e R matrici identità
Q1=eye(2);
R1=1;
[K1,P1,E1]=lqr(A,B,Q1,R1)
% K1 retroazione
% P1 soluzione eq algebrica riccati, utile per calcolo K, però per filtro
% di kalman non dà informazioni pratiche
% E1 autovalori di A-BK  

% K1 =    0.5458    0.4319 % richiesto
% E1 =   -2.1368    % anche se non chiesti meglio tenerseli
%    -4.8409

% controllo per posizionamento degli autovalori con specifica tempo di
% raggiungimento valore di regime =10s
% come posiziono gli autovalori di a-BK2
% Tr=10=>Tr=5*Td=>Td=2=>pd=-1/2 
% il secondo polo basta che non sia
% dominante
E2=[-0.5 -10];
% NB più lo metto distante dall'autovalore dominante, meno questo
% autovalore influenzerà la dinamica
K2=place(A,B,E2)
% K2 =
%    -0.5625    5.0625

% controllo LQ con cifra di merito uscita - ingresso
% con peso dell'uscita 10 volte maggiore di quello dell'ingresso
% devo stare attento a 2 cose:
% 1- la cifra di merito è uscita-ingresso ( è il contrario di prima)
        % significa J=int(y'Q3y+u'R3u)=>dim(Q3)=dim(R3)=1x1

        %J=int(Cx)'Q3(Cx)+u'R3u)=>=int(x'cx+u'R3u)
        %=int(Cx)'Q3(Cx)+u'R3u)se la inglobo in un'unica variabile, mi
        %porta nella staessa forma che ho usato per il primo
% posso usare ancora il comando lqr
% Q3=1
% R3=1
% Q3_stato=C'*Q3*C

% 2- l'uscita ha peso 10 volte l'ingresso
% io preferirò abbassare l'uscita rispetto all'ingresso
Q3=10
R3=1
Q3_stato=C'*Q3*C
[K3,P3,E3]=lqr(A,B,Q3_stato,R3)

% K3 =
%     2.5265    1.1582

% E3 =
%   -4.8423 + 2.3341i
%   -4.8423 - 2.3341i

%% PARTE B
% quale è il controllo più veloce?
% guardo gli autovalori di A-BK, in particolare l'autovalore dominante
%Tr1= Re(pd)=-2.13=>Td=0.5=0.2=>Tr1=2.5
%Tr2=10s
%Tr3=> Re(pd)=-4.8423=>Td=1/4.8423=0.2=>Tr3=1s

% NB tr3 è affetto da oscillazioni

%% EVENTUALE SIMULAZIONE
% prima possibilità:
% simulare il movimento liibero del sistema
% => ueq=0=>u=-Kx

% seconda possibilità:
%simulare il sistema con uno schema di contrllo che garantisca la
%conservazione del punto di equilibrio in anello aperto
%=>u=uwq-K(x-xeq)=>xeq è los tato di equilibrio del sistema controllato (
%in anello aperto) quando l'ingresso è ueq (xeq=-inv(A)*B*ueq)

% terza possibilità:
% simulare il sistema con uno schema di controllo che permetta 
% l'inseguimento di un setpoint y0 sull'uscita
% supponiamo di aver scelto giusto k in modo che il sistema sia stabile
% a regime y=y0
% u = alfa*y0-Kx
% alfa=-inv(C*inv(A-BK)*B) ( verificare sugliappunti)
alfa=-inv(C*(A-B*K3)*B)




%% supponiamo di voler calcolare K4 tc, u=alfa*y0-K4*x
% tale che deve minimizzare int(abs(u)+abs(y-y0) quando y0=5
% deve garantire anche 
% 0.3*K4(1)+0.2*K4(2)<3
% K4(1)>=0
% K4(2)>=0.1
% K4(1)<=1
% K4(1)<=0.5

% sfruttare il codice fornito in sede d'esame per risolvere il problema 
% (script_esame, fobj_esame)