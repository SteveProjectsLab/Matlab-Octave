function [tt,u]=ab3(odefun,tspan,y0,Nh,varargin);
%AB3  Risolve equazioni differenziali
%   usando un metodo multistep
%   [tn,un] = ab3(odefun,tspan,y0,Nh) con
%   TSPAN = [T0,TF] integra il sistema di equazioni
%   differenziali y' = f(t,y) dal tempo T0 a TF con
%   condizione iniziale Y0 usando il metodo di 
%   Adams-Bashfort 3 esplicito su una griglia equispaziata di 
%   Nh intervalli.
%   La funzione ODEFUN(T,Y) deve ritornare un vettore
%   contenente f(t,y), della stessa dimensione di y.
%   Ogni riga del vettore soluzione Y corrisponde ad
%   un istante temporale del vettore colonna T.
%   [T,Y] = AB3(ODEFUN,TSPAN,Y0,NH,P1,P2,...) passa
%   i parametri addizionali P1,P2,... alla funzione
%   ODEFUN come ODEFUN(T,Y,P1,P2...).

tt=linspace(tspan(1),tspan(2),Nh+1);
h=(tspan(2)-tspan(1))/Nh; 
y=y0(:);
w=y; u=y.';
hh=h*0.5; h12=h/12; h6=h/6;
% calcolo il secondo e il terzo dato iniziale con RK3
for t=tt(1:2)
  y = u(end,:);
  k1=odefun(t,w,varargin{:});
  t1 = t + hh; w1 = w + hh* k1;
  k2=odefun(t1,w1,varargin{:});
  t1 = t + h; w1 = w + h*(2*k2-k1);
  k3=odefun(t1,w1,varargin{:});
  w=w + h6*(k1+4*k2+k3);
  u = [u; w.'];
end
w1=u(1,:); w1=w1.';
w2=u(2,:); w2=w2.';
w3=u(3,:); w3=w3.';
fnm2=odefun(tt(1),w1,varargin{:});
fnm1=odefun(tt(2),w2,varargin{:});
w=w3;
% calcolo il passo generico
for t=tt(3:end-1)
  fn=odefun(t,w,varargin{:});
  w= w + h12*(23*fn-16*fnm1+5*fnm2);
  fnm2=fnm1;
  fnm1=fn;
  
  u = [u; w.'];
end
tt=tt';
