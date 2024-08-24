clear
close all
clc

syms x1 x2 u
f=[-x1+6*cos(x2);(x2^2+x2)*x1-x1*u+6*cos(x1)*u];
y=x2;
ueq=0;

xeq_s=solve(subs(f,u,ueq)==0)

xeq1=double([xeq_s.x1(1)  xeq_s.x2(1)])
xeq2=double([xeq_s.x1(2)  xeq_s.x2(2)])
xeq3=double([xeq_s.x1(3)  xeq_s.x2(3)])

% xeq1 =
% 
%      6     0
% 
% 
% xeq2 =
% 
%          0    1.5708
% 
% 
% xeq3 =
% 
%     3.2418   -1.0000


J_s=jacobian(f,[x1 x2])
J1=double(subs(J_s,[x1 x2 u],[xeq1 ueq]));
aval1=eig(J1)%sella
J2=double(subs(J_s,[x1 x2 u],[xeq2 ueq]));
aval2=eig(J2)% no pto eq perchè complesso coniugato
J3=double(subs(J_s,[x1 x2 u],[xeq3 ueq]));
aval3=eig(J3)% nodo stabile

% linearizzo attorno xeq3
Alin=J3
B_s=jacobian(f,u);
Blin=double(subs(B_s,[x1 x2 u],[xeq3 ueq]))
C_s=jacobian(y,[x1 x2]);
Clin=double(subs(C_s,[x1 x2 u],[xeq3 ueq]))
D=0


% controllo in retroazione dello stato
T=5;
td=T/5
pd=-1/td
a1=pd
K=place(Alin, Blin,[a1 2*a1])

x0=[3;-5];

%v=k*X