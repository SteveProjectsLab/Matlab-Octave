clear all

alfa=7.29;
beta=1;
K=10;
delta=10;

syms x1 x2
% definisco f
f1=K-alfa*x1*x2^2+beta*x2;
f2=alfa*x1*x2^2-delta*x2;
f=[f1;f2]

% calcolo punti di equilibrio
xeq_s=solve(f==0)
xeq=double([xeq_s.x1;xeq_s.x2]) % converto pti di equilibrio in double
% per studiare la stabilità devo calcolare la jacobiana di f nel punto di
% equilibrio

% calcolo la jacobiana
J_s=jacobian(f,[x1,x2])

% calcoliamo la jacobiana nel punto di equilibrio xeq
% sostituendo ai simboli x1 e x2 i valori di x1 e x2 all'equilibrio
% attraverso il comando subs

Jxeq_s=subs(J_s,[x1;x2],xeq) % Jxeq a valori simbolici
Jxeq=double(Jxeq_s) % Jxeq a valori reali

aval=eig(Jxeq) % xeq ha parte reale > 0 quindi il pto di equilibrio è instabile

% Essendo un sistema del secondo ordine
% possiamo classificare il pto di equilibrio:
% AUTOVALORI REALI
% concordi negativi=>nodo stabile
% concordi positivi => nodo instabile
% uno nullo e uno positivo=>nodo instabile
% discordi => sella
% AUTOVALORI SONO COMPLESSI E CONIUGATI
% parte reale negativa => fuoco stabile
% parte reale positiva => fuoco instabile

% QUANTI ATTRATTORI HA QUESTO SISTEMA?
% se consideriamo anche i punti di equilibrio come attrattori il sistema
% ha un attrattore (xeq)

% quale è il bacino di attrazione di xeq?
% essendo xeq instabile e non essendo una sella, il bacino di attrazione di
% xeq è solo xeq


