function [tt,u]=ab2(odefun,tspan,y0,Nh,varargin);
%AB2  Risolve equazioni differenziali
%   usando un metodo multistep
%   [tn,un] = ab2(odefun,tspan,y0,Nh) con
%   TSPAN = [T0,TF] integra il sistema di equazioni
%   differenziali y' = f(t,y) dal tempo T0 a TF con
%   condizione iniziale Y0 usando il metodo di 
%   Adams-Bashfort 2 esplicito su una griglia equispaziata di 
%   Nh intervalli.
%   La funzione ODEFUN(T,Y) deve ritornare un vettore
%   contenente f(t,y), della stessa dimensione di y.
%   Ogni riga del vettore soluzione Y corrisponde ad
%   un istante temporale del vettore colonna T.
%   [T,Y] = AB2(ODEFUN,TSPAN,Y0,NH,P1,P2,...) passa
%   i parametri addizionali P1,P2,... alla funzione
%   ODEFUN come ODEFUN(T,Y,P1,P2...).

tt=linspace(tspan(1),tspan(2),Nh+1);
h=(tspan(2)-tspan(1))/Nh; 
y=y0(:);
w=y; u=y.';
hmezzi=h*0.5;
% calcolo il secondo dato iniziale con RK2
t=tt(1);
k1=odefun(t,w,varargin{:});
t1 = t + hmezzi; w1 = w + hmezzi*k1;
k2=odefun(t1,w1,varargin{:});
w=w + hmezzi*(k1+k2);
u = [u; w.'];
f0=k1;
f1=odefun(tt(2),w1,varargin{:});
% calcolo il passo generico
for t=tt(2:end-1)
  w= w + hmezzi*(3*f1-f0);
  f0=f1;
  f1=odefun(t+h,w,varargin{:});
  u = [u; w.'];
end
tt=tt';
