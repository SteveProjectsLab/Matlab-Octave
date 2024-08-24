clear all

% dx/dt=Ax+Bu
% y=Cx+Du       (D=0)
A=[-1 5;0 -8];
B=[1 0]'; % ' è operatore di trasposizione
C=[1 5];
ueq=3;
x0=0;
%##########################################################################

% Punto 1: calcolo del punto di equilibrio
% Cosa è il pto di equilibrio?
% dx/dt=0=>Ax+Bu=0=>x=-inv(A)*B*u
xeq=-inv(A)*B*ueq
% inv(A)=>inversa della matrice A
% il prodotto * è righe x colonne di default
% se voglio il prodotto elto x elto=>.*

%##########################################################################

% PTO 2: stabilità del punto di equilibrio
aval=eig(A) % per avere stabilità gli autovalori devono avere parte reale <0


%##########################################################################

% PTO 3: scrivere la fdt del sistema
% Trasformo con Laplace la forma matriciale del sistema
% sX=AX+BU => sX-AX=BU => (sI-A)X=BU => X=inv(sI-A)*B*U
% Y=CX = >Y=C*inv(sI-A)*B*U => Y/U=G(s)=C*inv(sI-A)*B
s=tf('s');
G=C*inv(s*eye(2)-A)*B % G ha ordine 1=> il sistema ha una parte non osservabile e/o non raggiungibile

% Versione 2
sys_ss=ss(A,B,C,0); % D=0
sys_tf=tf(sys_ss)

%##########################################################################
% PUNTO 4: calcolare la stabilità dalla fdt
[z,p,k]=zpkdata(sys_tf,'v') % 'v' serve per avere l'output sotto forma di vettore

% perdo l'autovalore in -8=>ho parte non osservabile/non raggiungibile
% quale delle due?
% Studiare raggiungibilità
% Matrice di raggiungibilità R=[B A*B A^2*B... A^(n-1)*B]
% rango di R massimo=>completa raggiungibilità
R=ctrb(A,B) % calcolo matrice di raggiungibilità
rR=rank(R) % calcolo rango matrice di raggiungibilità
% rR=1 => sistema non completamente raggiungibile
% O=[C' A'C'...]
O=obsv(A,C)
rO=rank(O)
% rO=2 => il sistema è completamente osservabile

% Domanda: 
% quale è l'autovalore più veloce? -8 
% quale è l'autovalore dominante? -1 (dominante=>+ lento)
% il sistema oscilla? ha due autovalori reali=> non oscilla
% Supponiamo che A=[-1 5; 0 8]; B=[1;0]; C=[1 5]
A2=[-1 5; 0 8]; 
B2=[1;0]; 
C2=[1 5];
sys_tf2=tf(ss(A2,B2,C2,0))

