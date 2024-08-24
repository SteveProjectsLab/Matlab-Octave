function [tn,un]=eulero_imp(odefun,tspan,y0,Nh,varargin)
% eulero_imp: metodo di Eulero all'indietro per l'appx di e.d.o.
%  [tn,un]=eulero_imp(odefun,tspan,y0,Nh)
%  [tn,un]=eulero_imp(odefun,tspan,y0,Nh,tol)
%  [tn,un]=eulero_imp(odefun,tspan,y0,Nh,tol,kmax)
% Input: odefun = function handle di f(t,y)
%        tspan = [t0, T] vettore con istante iniziale e finale
%        y0 = condizione iniziale del p. di Cauchy
%        Nh = numero di passi temporali
%        tol, kmax = tolleranza e n. max di iterazioni 
%                    per secanti (opzionali)
% Output: tn = vettore colonna dei tempi
%         un = vettore colonna della soluzione numerica

% controllo gli input
if nargin==4
    % definisco tol e kmax con valori di default
    tol=1e-6;
    kmax=20;
elseif nargin ==5
    tol=varargin{1}; % varargin e' una struct
    kmax=20; % default
else
    tol=varargin{1};
    kmax=varargin{2};
end



t0=tspan(1); % istante iniziale
T=tspan(2); % istante finale
tn=linspace(t0,T,Nh+1)'; % vettore colonna dei tempi
un=zeros(Nh+1,1); % vettore colonna della soluzione numerica

un(1)=y0; % all'istante iniziale ho la cond. iniziale y0
h=(T-t0)/Nh;
% primo passo
r=@(x)x-un(1)-h*odefun(tn(2),x);
un(2)=secanti(r,un(1),un(1)+h,tol,kmax);

for n=2:Nh
     r=@(x)x-un(n)-h*odefun(tn(n+1),x);
     un(n+1)=secanti(r,un(n),un(n-1),tol,kmax);
end
