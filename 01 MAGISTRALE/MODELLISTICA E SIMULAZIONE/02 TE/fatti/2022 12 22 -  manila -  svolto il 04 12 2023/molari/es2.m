clear
close all
clc
%--------------------------------------------------------------------------
% punto (a)
%--------------------------------------------------------------------------
syms x1 x2 u

f=[(x1^2+x1)*x2;-4*x2+x1-x2*u+3*u]

ueq=0;
x0=[-0.1,0.1]';

% NB nela correzione se variabili sono giuste prendi punti anche schema simulink
% altrimenti va a vedere schema simulink

% calcolo punti di equilibrio
xeq_s=solve(subs(f,u,ueq)==0) %dx/dt=0 =>f=0

% risultano due punti di equilibrio, li casto da simbolico in numerico
xeq1=double([xeq_s.x1(1) xeq_s.x2(1)])
xeq2=double([xeq_s.x1(2) xeq_s.x2(2)])



%--------------------------------------------------------------------------
% punto (b)
%--------------------------------------------------------------------------
% ora ne studio la stabilità

% calcolo la jacobiana 
J_s=jacobian(f,[x1,x2])

% calcolo la jacobiana nei due punti di equilibrio
J1=double(subs(J_s,[x1,x2,u],[xeq1,ueq]));
J2=double(subs(J_s,[x1,x2,u],[xeq2,ueq]));
% calcolo gli autovalori per valutare la stabilità
aval1=eig(J1) % indecibilità ( ho un autovalore nullo)
aval2=eig(J2) % sella

%--------------------------------------------------------------------------
% Procedo alla linearizzazione I-O
g1=5*x1;
% clono le variabili per non sovrascriverle
F=f;
G=g1;
h=g1;



% y1 non dipende da u=> gr1>0
% calcolo dy1/dt = dy1/dx*dx/dt = dy1/dx*f
dy1=jacobian(h,[x1,x2])*F
% dy1 non dipende da u=> gr1>0
% calcolo ddy1
ddy1=jacobian(dy1,[x1,x2])*F
% ddy1 dipende da u=> gr1=2
%--------------------------------------------------------------------------
%considero ora y2

g2=3*x2;
F=f;
G=g2;
h=g2;

dy2=jacobian(h,[x1,x2])*F
% esce gr2=1

% non posso usare IO lin

% devo usare per forza y1

