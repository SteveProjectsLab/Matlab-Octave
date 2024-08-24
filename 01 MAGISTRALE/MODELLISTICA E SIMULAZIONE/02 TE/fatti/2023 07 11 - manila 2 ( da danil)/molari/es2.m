%Molari Stefano 727197

% esercizio 2

%--------------------------------------------------------------------------
% punto 1: Calcolare e studiare la stabilit`a dei punti di equilibrio del 
% sistema per u=0.
%--------------------------------------------------------------------------
clear
close all
clc

% inserisco il sistema
syms x1 x2 u
ueq=0;
f=[3*(x1^2+x1)*x2;-4*x2+x1-x2*u+3*u];
x0=[3;5];
% calcolo punti di equilibrio
xeq_s=solve(subs(f,u,ueq)==0)
xeq1=double([xeq_s.x1(1) xeq_s.x2(1)])
xeq2=double([xeq_s.x1(2) xeq_s.x2(2)])

% da console ne risultano due
% xeq1 =     0     0
% xeq2 =   -1.0000   -0.2500


% ne studio la stabilità per u=0
% linearizzo attorno ai due punti e calcolo gli autovalori

J_s=jacobian(f,[x1,x2])
%J_s =[x2*(6*x1 + 3), 3*x1^2 + 3*x1] [            1,       - u - 4]

J1=double(subs(J_s,[x1,x2,u],[xeq1,ueq]));
aval1=eig(J1)
J2=double(subs(J_s,[x1,x2,u],[xeq2,ueq]));
aval2=eig(J2)

% dal sistema linearizzato nel primo punto di equilibrio risultano i
% seguenti autovalori
% aval1 =    -4     0
% è un caso di indecibilità dato che ha un autovalore nullo

% dal sistema linearizzato nel secondo punto di equilibrio risultano i
% seguenti autovalori
% aval2 =   -4.0000    0.7500
% è una sella

%--------------------------------------------------------------------------
% punto 2: Valutare quale delle due uscite possa essere utilizzata per 
% la linearizzazione del sistema (supponendo in questo caso lo stato 
% misurabile o stimabile).
%--------------------------------------------------------------------------
% per fare ciò calcolo il grado relativo per entrambe le uscite
y1=5*x2;
% clono le variabili per non sovrascriverle
F1=f;G1=y1;h1=y1;
% y1 non dipende da u=> gr1>0
% calcolo dy1/dt = dy1/dx*dx/dt = dy1/dx*f
dy1=jacobian(h1,[x1,x2])*F1
% dy1 = 15*u + 5*x1 - 20*x2 - 5*u*x2
% dy1 dipende da u=> gr1=1
%--------------------------------------------------------------------------
y2=2*x1;
% clono le variabili per non sovrascriverle
F2=f;G2=y2;h2=y2;

% y2 non dipende da u=> gr1>0

% calcolo dy2/dt = dy2/dx*dx/dt = dy2/dx*f
dy2=jacobian(h2,[x1,x2])*F2
% dy2 = 2*x2*(3*x1^2 + 3*x1)
% dy2 non dipende da u=> gr1>1

% calcolo ddy2
ddy2=jacobian(dy2,[x1,x2])*F2
% ddy2 = (6*x1^2 + 6*x1)*(3*u + x1 - 4*x2 - u*x2) + 2*x2^2*(6*x1 + 3)*(3*x1^2 + 3*x1)
 
% ddy2 dipende da u=> gr1=2

% utilizzo la seconda uscita
%--------------------------------------------------------------------------
% punto 3:Progettare il controllo linearizzante (se possibile) 
% utilizzando l’uscita stabilita al punto (2).
%--------------------------------------------------------------------------

syms v
u_lin=solve(ddy2==v,u)

% risulta
%u_lin = ((6*x1^2 + 6*x1)*(x1 - 4*x2) - v + 2*x2^2*(6*x1 + 3)*(3*x1^2 + 3*x1))/((6*x1^2 + 6*x1)*(x2 - 3))

Alin=[0 1;0 0];
Blin=[0;1];
Clin=[1 0];

% k lo calcolo con il comando place per posizionamento autovalori
% a1 deve garantire tempo di raggiungimento T =2s
% il che significa che la costante sarà 2/5 ( 5 tau)
% T/5=tau
T=2;
td=T/5;
pd=-1/td;
a1=pd;
K=place(Alin,Blin,[a1,2*(a1)])

% devo calcolare il diffeomorfismo che lega z e x
% Z=T(x)
% NB devo togliere u da f!!!!
% f=[3*(x1^2+x1)*x2;-4*x2+x1];

f=[3*(x1^2+x1)*x2;-4*x2+x1];
T=[h2;jacobian(h2,[x1 x2])*f]

 
%K =   12.5000    7.5000

%T =   2*x1    2*x2*(3*x1^2 + 3*x1)