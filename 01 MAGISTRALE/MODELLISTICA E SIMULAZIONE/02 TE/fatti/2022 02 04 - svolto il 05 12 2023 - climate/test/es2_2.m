clear 
close all
clc

syms x1 x2 u
f=[(x1^2+x1)*x2;-2*x2+x1-x2*u+6*u]
x0=[3;5];

%##########################################################################
% punto a
%##########################################################################

% calcolo i punti di equilibrio per u=0
ueq=0;

xeq_s=solve(subs(f,u,ueq)==0)

% dall'output vedo che ci sono due punti di equilibrio
xeq1=double([xeq_s.x1(1) xeq_s.x2(1)])
xeq2=double([xeq_s.x1(2) xeq_s.x2(2)])

%xeq1 =     0     0
%xeq2 =   -1.0000   -0.5000

% per valutare la stabilità del sistema nei punti di equilibrio calcolo la
% jacobiana

J_s=jacobian(f,[x1 x2])

% valuto la jacobiana nei punti di equilibrio
J1=double(subs(J_s,[x1 x2 u],[xeq1,ueq]));
aval1=eig(J1)

J2=double(subs(J_s,[x1 x2 u],[xeq2,ueq]));
aval2=eig(J2)

%aval1 =    -2     0            % indecibilità
%aval2 =   -2.0000   0.5000     % sella


% Determinare un controllo in retroazione dello stato che permetta avere dinamica definita dalla coppia
% di autovalori autovalori [a1;2*a1], dove a1 deve permettere al sistema (considerando la linearizzazione
% ”perfetta”) di raggiungere l’equilibrio in un tempo T=1s.
% devo verificare che si possa fare la IO linearization

% calcolo il grado relativo
y=5*x1;
% y non dipende da u
F=f;G=y;h=y
dy=jacobian(h,[x1 x2])*F

% nemmeno dy
ddy=jacobian(dy,[x1 x2])*F

% gr=2 ok IO lin

% calcolo il controllo linearizzante

syms v
u_lin=solve(ddy==v,u)

A=[0 1;0 0];
B=[0;1];
C=[1 0];

T=1;
td=T/5;
pd=-1/td;
a1=pd;

K=place(A,B,[a1 2*a1])

F=[(x1^2+x1)*x2;-2*x2+x1];
T=[h;jacobian(h,[x1 x2])*F]

% u_lin =
% 
% ((5*x1^2 + 5*x1)*(x1 - 2*x2) - v + 5*x2^2*(2*x1 + 1)*(x1^2 + x1))/((5*x1^2 + 5*x1)*(x2 - 6))
% 
% 
% K =
% 
%    50.0000   15.0000
% 
% 
% T =
% 
%             5*x1
% 5*x2*(x1^2 + x1)



