clear
close all
clc

syms x1 x2 u
ueq=0;
f=[(x1^2+x1)*x2;-2*x2+x1-x2*u+6*u];
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

g=5*x1


% Procedo alla linearizzazione I-O
F=f;
G=g;
h=g;
dy=jacobian(h,[x1,x2])*F
ddy=jacobian(dy,[x1,x2])*F
syms v
u_lin=solve(ddy==v,u)



Alin=[0 1;0 0];
Blin=[0;1];
Clin=[1 0];

K=place(Alin,Blin,[-5,-2*(5)]);
T=[h;jacobian(h,[x1 x2])*f]
