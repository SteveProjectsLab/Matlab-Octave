clear all
close
clc

% dx/dt=Ax+Bu
% y=Cx+Du

A=[-1 5;0 -8]
B=[1;0]
C=[1 5]
u=3     % ingresso
x0=[3;5]% condizioni iniziali
%------------------------------------------------------------------------
%1. Calcolare il punto di equilibrio per u=3
%------------------------------------------------------------------------

%equilibrio: dx/dt=0 -> Ax+Bu=0 -> x=-inv(A)*B*u
xeq=-inv(A)*B*u

%------------------------------------------------------------------------
%2. Studiare la stabilità del punto di equilibrio del sistema
%------------------------------------------------------------------------

%calcolo gli autovalori di A -> stabile se autovalori hanno parte reale <0
autovalori=eig(A)

%il punto di equilibrio è stabile
%il sistema è lineare -> se il punto di equilibrio è stabile lo è anche il
%sistema

%------------------------------------------------------------------------
%3. Calcolare la funzione di trasferimento tra l%ingresso e l’uscita del sistema
%------------------------------------------------------------------------

%applico la trasformata di Laplace:
%   dx/dt=Ax+Bu -> sX=AX+BU -> sX-AX=BU -> (sI-A)X=BU -> X=inv(sI-A)*B*U
%   y=Cx+Du -> Y=CX+DU con D=0 -> Y=C*inv(sI-A)*B*U -> G(s)=Y/U=C*inv(sI-A)*B*U

s=tf('s')
G=C*inv(s*eye(2)-A)*B

% g ha ordine 1 quindi il sistema ha una parte non osservabile sull'uscita
% e non raggiungibile sull'ingresso

% metodo altenativo di inserimento
sys_ss=ss(A,B,C,0);%D=0
sys_tf=tf(sys_ss)

%NB
%parti non raggiungibili: ci sia una zona del sistema non impattata
%dall'ingresso (lega ingresso stato)

%parti non osservabili:(lega stato uscita)evolve lo stato ma non l'uscita

%------------------------------------------------------------------------
%4. Studiare la stabilità del sistema in questa forma
%------------------------------------------------------------------------

[z,p,k]=zpkdata(sys_tf,'v')%v per avere formato vettore

%perdo l'autovalore in 8, quinid ho parte non osservabile / non
%raggiungibile
%quale delle due? voglio studiare la raggiungibilità
%devo fare la matrice di ragg R=[B A*B A^2*B....a^(N-1)B

R=ctrb(A,B)% calcolo matrice di raggiungibilità
rR=rank(R)% calcolo rango matrice di osservabilità
% osservo che non è completamente raggiungibile perchè rR=1

%devo fare la matrice di osservabilità

%O=[C' A'C'...]o=obsv(A,C)
O=obsv(A,C)
rO=rank(O)

%osservo che è completamente osservabile O=2


%quale è l'autovalore più veloce?
% è -8, quello più a sinistra

% quello dominante è il più lento

%oscilla?
%ha autovalori reali, no


%supponiamo
%------------------------------------------------------------------------

A2=[-1 5;0 8]
B2=[1;0]
C2=[1 5]


sys_ss2=ss(A2,B2,C2,0);%D=0
sys_tf2=tf(sys_ss2)


% ha un polo positivo in +8, arriva l'ingresso 
%x2 diverge, l'altro stato no, a un certo punto esplode


%diverge, pendenza infinita.. ecc.. siamo nei guai.. a meno che sei un
%killer che vuole uccidere qualcuno