function [tt,u]=ab1am2(odefun,tspan,y0,Nh,varargin);
%AB1AM2  Risolve equazioni differenziali
%   usando un metodo multistep
%   [tn,un] = ab1am2(odefun,tspan,y0,Nh) con
%   TSPAN = [T0,TF] integra il sistema di equazioni
%   differenziali y' = f(t,y) dal tempo T0 a TF con
%   condizione iniziale Y0 usando il metodo di 
%   predictor corrector su Nh intervalli equispaziati con 
%   predictor= Adams-Bashfort 1 esplicito 
%   corrector= Adams-Moulton 2 implicito
%   La funzione ODEFUN(T,Y) deve ritornare un vettore
%   contenente f(t,y), della stessa dimensione di y.
%   Ogni riga del vettore soluzione Y corrisponde ad
%   un istante temporale del vettore colonna T.
%   [T,Y] = AB1AM2(ODEFUN,TSPAN,Y0,NH,P1,P2,...) passa
%   i parametri addizionali P1,P2,... alla funzione
%   ODEFUN come ODEFUN(T,Y,P1,P2...).

tt=linspace(tspan(1),tspan(2),Nh+1);
h=(tspan(2)-tspan(1))/Nh; 
y=y0(:);
w=y; u=y.';
hh=h*0.5; 
% calcolo il passo generico
for t=tt(1:end-1)
  fn=odefun(t,w,varargin{:});
  t1=t+h;
  w_tilde= w + h*fn;
  f_tilde=odefun(t1,w_tilde,varargin{:});
  w=w+hh*(f_tilde+fn);
  u = [u; w.'];
end
tt=tt';

