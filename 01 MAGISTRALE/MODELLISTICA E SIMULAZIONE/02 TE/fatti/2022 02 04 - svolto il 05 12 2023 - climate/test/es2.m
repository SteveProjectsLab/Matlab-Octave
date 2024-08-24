clear 
close all
clc

syms x1 x2 u
f=[(x1^2+x1)*x2;-2*x2+x1-x2*u+6*u]

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

%##########################################################################
%progetto il controllo linearizzante attraverso I-O linearization

% devo capire se posso applicarlo
% calcolo il grado relativo del sistema

y=5*x1;

% non c'è dipendenza esplicita da u in y, quindi gr>0
% calcolo la derivata prima
% duplico le variabili per fare i calcoli

F=f;G=y;h=y;

dy=jacobian(h,[x1 x2])*F

% dy =5*x2*(x1^2 + x1)
% non c'è dipendenza esplicita da u in dy, quindi gr>1

% calcolo la derivata seconda

ddy=jacobian(dy,[x1 x2])*F

% ddy =(5*x1^2 + 5*x1)*(6*u + x1 - 2*x2 - u*x2) + 5*x2^2*(2*x1 + 1)*(x1^2 + x1)
% c'è dipendenza da u in ddy, quindi gr=2
% dato che gr=grado sistema=> posso usare y per I/o linearization

% calcolo il controllo linearizzante
syms v
u_lin=solve(ddy==v,u)
% u_lin = ((5*x1^2 + 5*x1)*(x1 - 2*x2) - v + 5*x2^2*(2*x1 + 1)*(x1^2 + x1))/((5*x1^2 + 5*x1)*(x2 - 6))

%##########################################################################
% determino un controllo in retroazione dello stato che permette di avere
% dinamica definita dalla coppia di autovalori [a1;2*a1]
% dove a1 deve permettere al sistema di raggiungere l'equilibrio in 1s
Alin=[0 1; 0 0];
Blin=[0 1]';
Clin=[1 0];

% tau=T/5
T=1;
td=T/5;
pd=-1/td;
a1=pd;
k=place(Alin,Blin,[a1 2*a1])

% devo calcolare il diffeomorfismo che lega Z e X
% Z=T(x)
% tolgo u da F
f=[(x1^2+x1)*x2;-2*x2+x1];
T=[h;jacobian(h,[x1 x2])*f]

% non ho un setpoint, quindi la legge di controllo del sistema è
% v=-Kz=-K1*z1-K2*Z2

%k =   50.0000   15.0000

%T =[5*x1;5*x2*(x1^2 + x1)]

% ora faccio lo schema simulink
x0=[3 5]';

