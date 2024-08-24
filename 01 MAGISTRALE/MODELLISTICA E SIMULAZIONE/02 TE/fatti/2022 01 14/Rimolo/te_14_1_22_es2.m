clear all
clc

syms x1 x2 u
f=[(x1^2+x1)*x2;-x2+x1-x2*u+6*u];
ueq=0;
x0=[3;5];

% Punto 1
xeq_s=solve(subs(f,u,ueq)==0)
xeq1=double([xeq_s.x1(1),xeq_s.x2(1)])
% xeq1=[0 0]
xeq2=double([xeq_s.x1(2),xeq_s.x2(2)])
% xeq2=[-1 -1]

% Studio la stabilità dei punti di equilibrio
J_s=jacobian(f,[x1,x2])
% Valuto la jacobiana in xeq1
J1=double(subs(J_s,[x1,x2,u],[xeq1,ueq]))
aval1=eig(J1)
% Valuto la jacobiana in xeq2
J2=double(subs(J_s,[x1,x2,u],[xeq2,ueq]))
aval2=eig(J2)

% Non si può valutare la stabilità del primo punto di equilibrio, perchè ho
% un autovalore nullo quindi il metodo indiretto di Japunov non fornisce
% informazione. Il secondo punto di equilibrio è una sella, perchè ho un
% autovalore positivo e uno negativo

% Punto 2
g=x1;
F=f;
G=g;
h=g;

dy=jacobian(h,[x1,x2])*F
ddy=jacobian(dy,[x1,x2])*F
syms v
u_lin=solve(ddy==v,u)
% u_lin=((x1 - x2)*(x1^2 + x1) - v + x2^2*(2*x1 + 1)*(x1^2 + x1))/((x1^2 + x1)*(x2 - 6))

% Punto 3
T=1;
tau=T/5;
a1=-1/tau;
Alin=[0 1;0 0];
Blin=[0;1];
Clin=[1 0];
K=place(Alin,Blin,[a1,2*a1])
z=[h;jacobian(h,[x1,x2])*f]
% v=-Kz=-50*z1-15*z2
