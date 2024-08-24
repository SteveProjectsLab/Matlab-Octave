clear
close all
clc

%##########################################################################
% punto a
%##########################################################################
syms x1 x2 u
f=[(x1^2+x1)*x2;-4*x2+x1-x2*u+3*u]
x0=[-0.1;0.1]';
ueq=0;
% lo simulo ora su simulink, 
% utilizzando un orizzonte di simulazione pari a 1000s

%##########################################################################
% punto b
%##########################################################################

%calcolo i punti di equilibrio

xeq_s=solve(subs(f,u,ueq)==0)

% vedendo l'output capisco che ci sono due punti di equilbrio
xeq1=double([xeq_s.x1(1) xeq_s.x2(1)])
xeq2=double([xeq_s.x1(2) xeq_s.x2(2)])
%xeq1 =[ 0 0 ]';
%xeq2 =[-1.0000   -0.2500]';

% calcolo la jacobiana
J_s=jacobian(f,[x1 x2])

% la valuto nei due punti di equilibrio
J1=double(subs(J_s,[x1 x2 u], [xeq1 ueq]));
aval1=eig(J1)

J2=double(subs(J_s,[x1 x2 u], [xeq2 ueq]));
aval1=eig(J2)

% gli autovalori ottenuti sono

%aval1 =   -4     0
% condizione di indicibilità

%aval1 =   -4.0000    0.2500
% sella
%##########################################################################
% ora valutiamo quale delle due uscite può esser e utilizzata per la
% linearizzazione del sistema

% devo calcolare il grado relativo del sistema

y1=5*x1;

%clono le variabili per fare i calcoli
F1=f; G1=y1; h1=y1;

% non c'è una dipendenza esplicita da u, quindi gr>0

% calcolo la derivata prima
dy1=jacobian(h1,[x1 x2])*F1
% l'output è dy1=5*x2*(x1^2 + x1)
% non c'è dipendenza esplicita da u in y, quindi gr>1

% calcolo la derivata seconda
ddy1=jacobian(dy1,[x1 x2])*F1
% l'output è ddy1 =(5*x1^2 + 5*x1)*(3*u + x1 - 4*x2 - u*x2) + 5*x2^2*(2*x1 + 1)*(x1^2 + x1)
% c'è dipendenza esplicita da u, quindi gr=2

% grado relativo = grado sistema => posso usare y1 per I/O Linearization

%##########################################################################
%analogamente procedo con la seconda uscita

y2=3*x2;

%clono le variabili per fare i calcoli
F2=f; G2=y2; h2=y2;

% non c'è una dipendenza esplicita da u in y, quindi gr>0
% calcolo la derivata prima
dy2=jacobian(h2,[x1 x2])*F2
% l'output è dy2 = 9*u + 3*x1 - 12*x2 - 3*u*x2
% c'è dipendenza esplicita da u in dy2, quindi gr=1

% grado relativo < grado sistema => NON posso usare y2 per I/O Linearization
%##########################################################################