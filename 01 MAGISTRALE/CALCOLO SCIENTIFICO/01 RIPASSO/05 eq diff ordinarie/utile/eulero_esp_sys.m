function [tn,un]=eulero_esp_sys(edofun,tspan,y0,Nh)
%Metodo di Eulero in avanti per sistemi di eq. differenziali
%differenziali ordinarie
%INPUT:
%   edofun: equazione differenziale
%   tspan: istanti di tempo iniziale e finale
%   y0: condizione iniziale
%   Nh: numero di passi
%OUTPUT;
%   tn:
%   un:
%trasformo y0 in vettore colonna
y0=y0(:);

d=length(y0);
t0=tspan(1);
T=tspan(2);
tn=linspace(t0,T,Nh+1)';
un=zeros(Nh+1,d);

un(1,:)=y0.';
h=tn(2)-tn(1);
for n=1:Nh
    wn=un(n,:).';
    w=wn+h*edofun(tn(n),wn);
    un(n+1,:)=w.';
end
end