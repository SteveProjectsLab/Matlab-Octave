function [tn,un]=eulero_esp(odefun,tspan,y0,Nh)
% eulero_esp: metodo di Eulero in avanti per l'appx di e.d.o.
%  [tn,un]=eulero_esp(odefun,tspan,y0,Nh)
% Input: odefun = function handle di f(t,y)
%        tspan = [t0, T] vettore con istante iniziale e finale
%        y0 = condizione iniziale del p. di Cauchy
%        Nh = numero di passi temporali
% Output: tn = vettore colonna dei tempi
%         un = vettore colonna della soluzione numerica

t0=tspan(1); % istante iniziale
T=tspan(2); % istante finale
tn=linspace(t0,T,Nh+1)'; % vettore colonna dei tempi
un=zeros(Nh+1,1); % vettore colonna della soluzione numerica

un(1)=y0; % all'istante iniziale ho la cond. iniziale y0
h=(T-t0)/Nh;
for n=1:Nh
    un(n+1)=un(n)+h*odefun(tn(n),un(n));
end
