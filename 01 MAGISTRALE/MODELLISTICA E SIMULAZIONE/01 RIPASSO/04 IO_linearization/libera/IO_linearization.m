clear
close all
clc
%##########################################################################
% da TE 2022 02 04
%##########################################################################
syms x1 x2 u
ueq=0;
x0=[3 5]';
f=[(x1^2+x1)*x2;-2*x2+x1-x2*u+6*u];
%--------------------------------------------------------------------------
% punto 1   PUNTI DI EQUILIBRIO E STABILITA'
%--------------------------------------------------------------------------
%1. Calcolare e studiare la stabilit`a dei punti di equilibrio del sistema per u=0.
xeq_s=solve(subs(f,u,ueq)==0)
xeq1=double([xeq_s.x1(1) xeq_s.x2(1)])
xeq2=double([xeq_s.x1(2) xeq_s.x2(2)])

% calcolo punti di equilibrio
J_s=jacobian(f,[x1,x2])
J1=double(subs(J_s,[x1,x2,u],[xeq1,ueq]));
aval1=eig(J1)
J2=double(subs(J_s,[x1,x2,u],[xeq2,ueq]));
aval2=eig(J2)
% 2 pti equilibrio
% primo indecibile
% secondo sella

%--------------------------------------------------------------------------
% punto 2       IO linearization
%--------------------------------------------------------------------------
%2. Progettare il controllo linearizzante attraverso I-O linearization.


y=5*x1
% non dipende da u, quindi non ha grado relativo 0

% Procedo alla linearizzazione I-O
F=f;
Y=y;
h=y;
% calcolo la derivata prima
dy=jacobian(h,[x1,x2])*F
% neanche lei dipende da u

% calcolo la derivata seconda
ddy=jacobian(dy,[x1,x2])*F
% il sistema ha grado relativo 2 

% il controllo linearizzante lo ottengo imponendo derivata ennersima uguale
% all'ingreasso
syms v
u_lin=solve(ddy==v,u)
%l'uscita è uguale all'integrale due volte dell'ingresso

% u_lin =
% 
% ((5*x1^2 + 5*x1)*(x1 - 2*x2) - v + 5*x2^2*(2*x1 + 1)*(x1^2 + x1))/((5*x1^2 + 5*x1)*(x2 - 6))
%--------------------------------------------------------------------------
% punto 3   CONTROLLO IN RETROAZIONE DELLO STATO
%--------------------------------------------------------------------------
% Determinare un controllo in retroazione dello stato che permetta avere dinamica definita dalla coppia
% di autovalori autovalori [a1;2*a1], dove a1 deve permettere al sistema (considerando la linearizzazione
% ”perfetta”) di raggiungere l’equilibrio in un tempo T=1s.

% il nostro controllore vede un sistema lineare
% Y/V=1/s^2
% NB è nello stato z diverso da x, quindi il controllo sarà del tipo v=-kZ

Alin=[0 1;0 0];
Blin=[0;1];
Clin=[1 0];

% k lo calcolo con il comando place per posizionamento autovalori
% a1 deve garantire tempo di raggiungimento T =1s
% il che significa che la costante sarà 1/5 ( 5 tau)
% T/5=tau

T=1;
td=T/5;
pd=-1/td;
a1=pd;
K=place(Alin,Blin,[a1,2*(a1)])

% K =
% 
%    50.0000   15.0000

% devo calcolare il diffeomorfismo che lega z e x
% Z=T(x)
%f=[(x1^2+x1)*x2;-2*x2+x1-x2*u+6*u];

% NB devo togliere u!!!!
f=[(x1^2+x1)*x2;-2*x2+x1];
T=[h;jacobian(h,[x1 x2])*f]
 
% T =
%             5*x1
% 5*x2*(x1^2 + x1)
 
% ora apro simulink e disegno lo schema, inserendo i parametri qua
% calcolati.
