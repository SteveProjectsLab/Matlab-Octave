% (a) Scrivere uno script MATLAB che permetta di:
% 1. Calcolare e studiare la stabilit`a dei punti di equilibrio del sistema per u=0. Verificare che uno dei punti
% di equilibrio `e (circa) x1 = [3.2418 − 1].
% 2. Calcolare il sistema (A,B,C) linearizzato attorno al punto di equilibrio x1 = [3.2418 − 1].
% 3. Determinare un controllo in retroazione dello stato utilizzando il sistema linearizzato attorno a x1 =
% [3.2418 − 1], in modo che la dinamica definita dagli autovalori [a1;2*a1], dove a1 permetta al sistema
% (considerando la linearizzazione ”perfetta”) di raggiungere l’equilibrio in un tempo T=5s quando u=0.

syms x1 x2 u
f=[-x1+6*cos(x2);(x2^2+x2)*x1-x1*u+6*cos(x1)*u];
y=x2;
ueq=0;
xeq_s=solve(f==0) 
x0=[3 5]';
% punti di equilibrio
xeq_s=solve(subs(f,u,ueq)==0)

xeq1=double([xeq_s.x1(1) xeq_s.x2(1)])
xeq2=double([xeq_s.x1(2) xeq_s.x2(2)])
xeq3=double([xeq_s.x1(3) xeq_s.x2(3)]) % è quello richiesto dal testo

%xeq1 =   [  6     0]
%xeq2 =     0    1.5708
%xeq3 =    3.2418   -1.0000

% STABILITA' PTI DI EQUILIBRIO
% devo calcolare la jacobiana di f nelle direzioni delel variabili di stato
J_s=jacobian(f,[x1,x2])


% Calcolo la matrice nei punti di equilibrio e calcolo i valori
J1=double(subs(J_s,[x1,x2,u],[xeq1,ueq]));
aval1=eig(J1)
J2=double(subs(J_s,[x1,x2,u],[xeq2,ueq]));
aval2=eig(J2)
J3=double(subs(J_s,[x1,x2,u],[xeq3,ueq]));
aval2=eig(J3)
%aval1 =    -1     6
%aval2 =  -0.5000 + 4.8969i  -0.5000 - 4.8969i
%aval2 =   -1.0000   -3.2418
%---------------------------------------------------------------------------
% punto 2
%---------------------------------------------------------------------------
%Calcolare il sistema (A,B,C) linearizzato attorno al punto di equilibrio x1 = [3.2418 − 1].
A3=J3;
B_s=jacobian(f,u)
B3=double(subs(B_s,[x1,x2,u],[xeq3,ueq]))
C_s=jacobian(y,[x1 x2]);
C3=double(subs(C_s,[x1,x2,u],[xeq3,ueq]))
D_s=jacobian(y,u)
D3=double(subs(D_s,[x1,x2,u],[xeq3,ueq]))


%---------------------------------------------------------------------------
% punto 2
%---------------------------------------------------------------------------

T=5;
td=T/5;
pd=-1/td;
a1=pd;
K=place(A,B,[a1,2*(a1)])

% Legge di controllo del sistema: v=-Kz=-K1*z1-K2*z2

x0=[3;-5];

