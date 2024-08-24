clear all
clc
b=0.004;
g=0.04;
d=0.1; % = delta
m=1e-3; % = mu
e=0.001;
x0=[97,3,0];

% Il sistema SIR è un sistema nonlineare perché c'è il prodotto S*I
% Come calcolo i punti di equilibrio di un sistema nonlineare?
% In linea di massima metodologicamente non cambia il significato di punto
% di equilibrio (punto in cui a fronte di un ingresso costante lo stato è
% costante
% => dx/dt=0 "vale" anche per i sistemi non lineari
% scrivo dx/dt=f(x,u)    (in questo caso u=d)
syms S I R  % definisco variabili di tipo simbolico
% CASO e=0
% xeq1=[100,0,0]; aval1=[-0.001,-0.001,0.3590] => instabile
% xeq2= [10.25 2.189 87.561]; aval2=[-0.001, -0.004+-0.0183i]=>stabile

% CASO e=0.001
% xeq1=[100,0,0]; aval1=[-0.001,-0.001,0.3590] => instabile
% xeq2= [10.5 2.131 85.2381]; aval2=[-0.001, -0.0048+-0.0183i]=>stabile

f=[d-b*S*I-m*S;b*S*I-g*I-m*I-e*I;g*I-m*R]

% PTI DI EQUILIBRIO
% dx/dt=0=>f=0
xeq_s=solve(f==0) 
% xeq_s è ancora una variabile di tipo symbol.
% E' una struttura che ha come campi le variabili rispetto alle quali
% abbiamo risolto il sistema f=0 (S,I,R)
% se vogliamo convertire un simbolo che rappresenta un numero
% in una variabile reale dobbiamo usare il comando double
xeq1_s=[xeq_s.S(1),xeq_s.I(1),xeq_s.R(1)];
xeq2_s=[xeq_s.S(2),xeq_s.I(2),xeq_s.R(2)];

xeq1=double(xeq1_s)
xeq2=double(xeq2_s)

% STABILITA' PTI DI EQUILIBRIO
% devo calcolare la jacobiana di f nelle direzioni di S,I,R
A_s=jacobian(f,[S,I,R]) % [S,I,R] indica l'ordine (e quindi la colonna) delle derivate parziali
% Attenzione! L'ouput è una matrice di simboli

% Calcolo la matrice A nel pto di equilibrio 1
A1_s=subs(A_s,[S,I,R],xeq1)
A1=double(A1_s)
aval1=eig(A1) % a questo punto A1 è una matrice di numeri reali e a me servono i suoi autovalori

A2_s=subs(A_s,[S,I,R],xeq2)
A2=double(A2_s)
aval2=eig(A2) % a questo punto A1 è una matrice di numeri reali e a me servono i suoi autovalori



