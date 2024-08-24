clear all
A=[-1 4;1 -5];
B=[1 1]';
C1=[1 2];%uscita 1
C2=[0.1 0.1];%uscita 2 
G=eye(2)
Rw=[0.1 0;0 0.01];
Rv=0.01;
% verifico che valgano le ipotesi del filtro di kalman per entrambe le
% uscite
rG=rank(ctrb(A,G)) % ha rango 2 come il n° di variabili di stato, indipendentemente dall'uscita
rO1=rank(obsv(A,C1)) % ha rango 2 come il n° di variabili di stato
rO2=rank(obsv(A,C2)) % ha rango 2 come il n° di variabili di stato
% entrambe le uscite mi garantiscono completa osservabilità
% non potendone quindi escludere una, deov progettare il filtro di Kalman e
% valutare le prestazioni

[L1,P1,Eo1]=lqe(A,G,C1,Rw,Rv)
[L2,P2,Eo2]=lqe(A,G,C2,Rw,Rv)
% cosa si intende per prestazioni del filtro di kalman?
% l'obiettivo finale del filtro di kalman è minimizzare la varianza
% dell'errore di stima
% quindi guardo la diagonale delle matrici P1 e P2
diag(P1)   % 0.0225    0.0012
diag(P2)   % 0.1448    0.0064

% queste sono le varianze degli errori di stima
% è meglio l'uscita 1, perchè ho meno varianza dell'errore in entrambi i
% casi

% se invece solo uno stato fosse migliore in termini di varianza, valuto su
% velocità di stima e sullo stato che intendo utilizzare  per il controllo

% punto B, 3 
% come è fattto l'osservatore non kalmna?
% devo valutare la dinamica del sistema, calcolo gli autovalori della
% matrice A
aval=eig(A) % il problema è ben posto perchè il sistema è stabile
aval_doppia=2*aval
L=place(A',C1',aval_doppia)
