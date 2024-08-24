function [tn,un]=eulero_imp_sys(odefun,tspan,y0,Nh, varargin)
% eulero_imp_sys: metodo di Eulero implicito per l'appx di sistemi di edo
%                 richiede broyden.m
%  [tn,un]=eulero_imp_sys(odefun,tspan,y0,Nh)
%  [tn,un]=eulero_imp_sys(odefun,tspan,y0,Nh,tol)
%  [tn,un]=eulero_imp_sys(odefun,tspan,y0,Nh,tol,kmax)
%
% Input: odefun = function handle di f(t,y)
%        tspan = [t0, T] vettore con istante iniziale e finale
%        y0 = condizione iniziale del p. di Cauchy
%        Nh = numero di passi temporali
%        tol, kmax = tolleranza e n. max di iterazioni 
%                    per Broyden (opzionali)
%
% Output: tn = vettore colonna dei tempi
%         un = matrice della soluzione numerica, 
%              ogni colonna contiene una componente della soluzione
%              del sistema

% controllo gli input per definire tol e kmax per Broyden 
if nargin==4
    % definisco tol e kmax di default
    tol=1e-8;
    kmax=50;
elseif nargin==5
    % prendo tol da input
    tol=varargin{1};
    kmax=50;
elseif nargin==6
    % prendo sia tol che kmax da input
    tol=varargin{1};
    kmax=varargin{2};
end

y0=y0(:); % y0 viene convertito sempre in vettore colonna

% da y0 leggo il numero di equazioni
d=length(y0); 

% h = passo temporale
h=(tspan(2)-tspan(1))/Nh;

% vettore dei tempi
tn=linspace(tspan(1),tspan(2),Nh+1)';
% vettore soluzione
un=zeros(Nh+1,d);

un(1,:)=y0.'; % .' realizza la trasposta anche sui complessi
% ' farebbe complesso coniugato

B0=eye(d);
for n=1:Nh
    % definisco la funzione nonlineare per Broyden
    wn=un(n,:).';
    r=@(x)x-wn -h*odefun(tn(n+1),x);
    % chiamo Broyden per risolvere r(x)=0 con dato iniziale wn
    w=broyden(r,B0,wn,tol,kmax);
    un(n+1,:)=w.';
end

 





