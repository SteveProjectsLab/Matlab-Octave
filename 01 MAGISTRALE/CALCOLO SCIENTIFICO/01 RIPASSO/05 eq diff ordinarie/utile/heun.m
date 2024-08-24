function [tn,un]=heun(odefun,tspan,y0,Nh)
% metodo di Heun per approssimare eq e sistemi di eq. diff. ord
% [tn,un]=heun(odefun,tspan,y0,Nh)
% Input: odefun= function handle della f(t,y(t)) del PdC
%        tspan=[t0,T] estremi dell'intervallo di integrazione
%        y0= condizione iniziale
%        Nh = numero di passi della discretizzazione
% Output: tn = vettore dei tempi
%         un = matrice della soluzione numerica: 
%         per ogni riga abbiamo un tempo diverso e
%         per ogni colonna abbiamo una componente diversa della soluzione

% genero il vettore dei tempi (da t0 a T)
tn=linspace(tspan(1),tspan(2),Nh+1)';

d=length(y0); % dimensione del sistema = numero di funzioni incognite
% vettore della soluzione
un=zeros(Nh+1,d);

% modifico y0, in modo che sia sempre un vettore colonna
y0=y0(:);

% salvo nella prima componente la condizione iniziale
un(1,:)=y0.'; % trasposto vero e proprio 
%(' nel caso di numeri complessi realizza il complesso coniugato)

% passo di discretizzazione
h=(tspan(2)-tspan(1))/Nh;
h2=h/2;

% costruisco la soluzione numerica
for n=1:Nh
wn=un(n,:).'; % sol al passo t_n, voglio che sia vettore colonna
fn=odefun(tn(n),wn);
wnstar=wn+h*fn; % predictor
w=wn+h2*(fn+odefun(tn(n+1),wnstar)); % corrector
un(n+1,:)=w.'; % w viene trasposto per diventare riga (n+1)-sima in un
  
end

