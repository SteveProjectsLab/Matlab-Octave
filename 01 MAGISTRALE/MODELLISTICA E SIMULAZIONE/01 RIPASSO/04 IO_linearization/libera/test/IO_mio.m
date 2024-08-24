clear all
clc

%#########################################################################
% 1. Calcolare e studiare la stabilit`a dei punti di equilibrio del sistema per u=0.
syms x1 x2 u
f=[(x1^2+x1)*x2;
    -2*x2+x1-x2*u+6*u]
y=5*x1

ueq=0;
x0=[3;5];


xeq_s=solve(subs(f,u,ueq)==0)

xeq1=double([xeq_s.x1(1) xeq_s.x2(1)])
xeq2=double([xeq_s.x1(2) xeq_s.x2(2)])

% xeq1 =
%      0     0
% xeq2 =
%    -1.0000   -0.5000


%per studiare la stablità devo calcolare la jacobiana 
% e valutarla in xeq1 xeq2
J_s=jacobian(f,[x1 x2])
J1=double(subs(J_s,[x1 x2 u],[xeq1,ueq]))
J2=double(subs(J_s,[x1 x2 u],[xeq2,ueq]))
aval1=eig(J1)
aval2=eig(J2)


% aval1 =
% 
%     -2
%      0        % indicibile
% 
% aval2 =
% 
%    -2.0000
%     0.5000    % sella

%#########################################################################
% 2. Progettare il controllo linearizzante attraverso I-O linearization.

% per poter fare IO linearization devo calcolare il grado relativo
F=f; h=y;

%calcolo la derivata prima
dy=jacobian(h,[x1 x2])*F
% dy =
% 
% 5*x2*(x1^2 + x1)

% la u non compare esplicitamente in dy

% calcolo la derivata seconda
ddy=jacobian(dy,[x1 x2])*F

% ddy =
% 
% (5*x1^2 + 5*x1)*(6*u + x1 - 2*x2 - u*x2) + 5*x2^2*(2*x1 + 1)*(x1^2 + x1)

% la u compare esplicitamente quindi il grado relativo è 2

% grado sistema = grado relativo -> posso fare IO linearization.

syms v
u_lin=solve(ddy==v,u)

% u_lin =
% 
% ((5*x1^2 + 5*x1)*(x1 - 2*x2) - v + 5*x2^2*(2*x1 + 1)*(x1^2 + x1))/((5*x1^2 + 5*x1)*(x2 - 6))


%#########################################################################
% 3. Determinare un controllo in retroazione dello stato che permetta avere dinamica definita dalla coppia
% di autovalori autovalori [a1;2*a1], dove a1 deve permettere al sistema (considerando la linearizzazione
% ”perfetta”) di raggiungere l’equilibrio in un tempo T=1s.

% il nostro controllore vede un sistema lineare
% Y/V=1/s^2
% NB è nello stato z diverso da x, quindi il controllo sarà del tipo v=-kZ

Alin=[0 1;0 0];
Blin=[0;1];
Clin=[1 0];

T=1;
td=T/5;
pd=-1/td;
a1=pd;
k=place(Alin,Blin,[a1;2*a1])

% k =
% 
%     50.0000    15.0000

%z=T(x)
f=[(x1^2+x1)*x2;
    -2*x2+x1]
T=[h;jacobian(h,[x1 x2])*f]

% T =
% 
%             5*x1
% 5*x2*(x1^2 + x1)