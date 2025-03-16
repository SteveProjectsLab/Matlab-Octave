function [tn,un]=cranknicolson(odefun,tspan,y0,Nh,varargin);
%   [tn,un]=cranknicolson(odefun,tspan,y0,Nh);
%   approssimazione del pdC del primo ordine con Crank Nicolson
%   funziona SOLO per equazioni scalari, l'equazione non lineare
%   e' risolta con il metodo delle sacanti (da secant.m)
%
%   tspan = [t0,T] integra il sistema di equazioni
%   differenziali y' = f(t,y) dal tempo t0 a T con
%   condizione iniziale y0 usando il metodo di Eulero
%   all'indietro su una griglia equispaziata di Nh
%   intervalli.
%   La funzione ODEFUN(T,Y) deve ritornare un vettore
%   contenente f(t,y), della stessa dimensione di y.
%   Ogni riga del vettore soluzione un corrisponde ad
%   un istante temporale del vettore colonna tn.
%   Nel caso siano assegnati solo 4 parametri di input, 
%   la tolleranza e num.max di iterazioni per secanti
%   sono pari a tol=1.e-8; nmax=20;
%   Altrimenti
%   [tn,un]=eulero_imp(odefun,tspan,y0,Nh,tol,nmax)
%   specifica anche tol e nmax per secanti.
% 

% controllo variabili in input
if nargin==4
% settiamo i parametri per secanti
tol=1.e-8; nmax=20;
else
    tol=varargin{1};
    nmax=varargin{2};
end
% costruisco il vettore dei tempi t_n
t0=tspan(1);
T=tspan(2);
tn=linspace(t0,T,Nh+1)';
% calcolo h
h=(T-t0)/Nh;
% costruisco il vettore della soluzione numerica
un=zeros(Nh+1,1);
un(1)=y0;


% n=1: calcolo u_(n+1)
n=1;
F=@(x)x-un(n)-h/2*(odefun(tn(n),un(n))+...
    odefun(tn(n+1),x));
un(n+1)=secant(F,un(n),un(n)+h,tol,nmax);

% ciclo per n>=2
for n=2:Nh
    F=@(x)x-un(n)-h/2*(odefun(tn(n),un(n))+...
    odefun(tn(n+1),x));
    un(n+1)=secant(F,un(n),un(n-1),tol,nmax);
end

