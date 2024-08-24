clear
close all
clc

%Es.1

syms X1 X2 u1 u2
X=[X1;X2];
u=[u1;u2];

%modello: dX/dt=F(X,u)
%         y=G(X,u)

F=[-0.1*X1+1.1*u1;          %dX1/dt
   0.5*X1+1.5*u2-0.3];      %dX2/dt
y=a1*X1+a2*X2;              %y

%Per controllare la probabilità di vittoria è preferibile utilizzare il
%carico di lavoro (ingresso u1) in quanto influenza entrambe le variabili
%di stato (X1 direttamente e X2 indirettamente attraverso X1), mentre le
%ore con lo psicologo influenzano solo la variabile di stato X2 (in quanto
%la variazione di X1 non dipende da X2).