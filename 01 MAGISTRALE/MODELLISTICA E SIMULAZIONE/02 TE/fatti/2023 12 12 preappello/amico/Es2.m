clear
close all
clc

%Es.2

syms X1 X2 u v

ueq=-0.1;
x0=[3;-3];

%sistema non lineare
F=[(-X2^2-X2)*X1;
   -X1-X2-X1*u+3*u];
y=5*X1;

%calcolo punti di equilibrio
xeq=solve(subs(F,u,ueq)==0);

xeq1=double([xeq.X1(1) xeq.X2(1)]);
xeq2=double([xeq.X1(2) xeq.X2(2)]);
xeq3=double([xeq.X1(3) xeq.X2(3)]);

%calcolo lo Jacobiano
J_s=jacobian(F,[X1 X2]);

%valuto il punto di equilibrio xeq1
J1=subs(J_s,[X1 X2 u],[xeq1 ueq]);
J1=double(J1);
aval1=eig(J1);    

%valuto il punto di equilibrio xeq2
J2=subs(J_s,[X1 X2 u],[xeq2 ueq]);
J2=double(J2);
aval2=eig(J2);     

%valuto il punto di equilibrio xeq3
J3=subs(J_s,[X1 X2 u],[xeq3 ueq]);
J3=double(J3);
aval3=eig(J3);

% xeq1 = [-0.3333;0]
% aval1 = [-0.5000 + 0.2236i; -0.5000 - 0.2236i]
%gli autovalori sono complessi coniugati e a parte reale negativa => fuoco, stabile
% 
% xeq2 = [0;-0.3000]
% aval2 = [-1.0000;0.2100]
%ho un autovalore positivo e uno negativo => sella, instable
%          
% xeq3 = [0.7778;-1.0000]
% aval3 = [-0.5000 + 0.6708i;-0.5000 - 0.6708i]
%gli autovalori sono complessi coniugati e a parte reale negativa => fuoco, stabile
%     

%porto il sistema nella forma dx/dt = f(x)+g(x)*u
%                             y=h(x)
f=[(-X2^2-X2)*X1;
   -X1-X2];
g=[0;
   -X1+3];
h=y;
%valuto il grado relativo dl sistema
%h non dipende direttamente da u => r!=0
dh=jacobian(h,[X1 X2])*F;
%dh/dt non dipende direttamente da u => r!=1
d2h=jacobian(dh,[X1 X2])*F;
%d^2h/dt^2 dipende direttamente da u => r=2
%r coincide con l'ordine del sistema, quindi applicare la linearizzazione
%I-O

%calcolo il controllo linearizzante
u_lin=solve(d2h==v,u);

%espressione controllo linearizzante
%u_lin=-(X1*(5*X2^2 + 5*X2)*(X2^2 + X2) - v + 5*X1*(X1 + X2)*(2*X2 + 1))/(5*X1*(2*X2 + 1)*(X1 - 3))

%scrivo il sistema nella forma linearizzata dZ/dt = A*Z+B*v
%                                           y = C*Z
A=[0 1;
   0 0];
B=[0;
   1];
C=[1 0];

%calcolo il diffeomorfismo che lega Z e X
T=[h;jacobian(h,[X1 X2])*f];