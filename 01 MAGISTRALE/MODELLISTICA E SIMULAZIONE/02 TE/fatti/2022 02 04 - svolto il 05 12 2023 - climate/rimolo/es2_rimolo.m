clear all
clc
syms x1 x2 u
f=[(x1^2+x1)*x2;-2*x2+x1-x2*u+6*u];
ueq=0;
x0=[3;5];
% Punto 1
xeq_s=solve(subs(f,u,ueq)==0)
xeq1=double([xeq_s.x1(1),xeq_s.x2(1)])
xeq2=double([xeq_s.x1(2),xeq_s.x2(2)])
% Stabilità
J_s=jacobian(f,[x1,x2])
% Valuto la jacobiana in xeq1
J1=double(subs(J_s,[x1,x2,u],[xeq1,ueq]))
aval1=eig(J1)
% Valuto la jacobiana in xeq2
J2=double(subs(J_s,[x1,x2,u],[xeq2,ueq]))
aval2=eig(J2)
% xeq1 è una condizione di indicibilità, xeq2 è una sella
% Punto 2
g=5*x1;
F=f;
G=g;
h=g;
dy=jacobian(h,[x1,x2])*F
ddy=jacobian(dy,[x1,x2])*F
% Il sistema ha grado relativo 2 pari all'ordine del sistema=> posso
% applicare la I-O linearization
syms v
u_lin=solve(ddy==v,u)
% Punto 3
T=1;
tau=T/5;
a1=-1/tau;
Alin=[0 1;0 0];
Blin=[0;1];
Clin=[1 0];
K=place(Alin,Blin,[a1,2*a1])
z=[h;jacobian(h,[x1,x2])*f]