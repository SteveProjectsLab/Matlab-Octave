function [t,u]=beuler(odefun,tspan,y0,Nh,varargin)
%BEULER  Risolve equazioni differenziali
%   usando il metodo di Eulero all'indietro.
%   [tn,un] = Beuler(odefun,tspan,y0,Nh) con
%   TSPAN = [T0,TF] integra il sistema di equazioni
%   differenziali y' = f(t,y) dal tempo T0 a TF con
%   condizione iniziale Y0 usando il metodo di Eulero
%   all'indietro su una griglia equispaziata di NH
%   intervalli.
%   La funzione ODEFUN(T,Y) deve ritornare un vettore
%   contenente f(t,y), della stessa dimensione di y.
%   Ogni riga del vettore soluzione Y corrisponde ad
%   un istante temporale del vettore colonna T.
%   [T,Y] = BEULER(ODEFUN,TSPAN,Y0,NH,P1,P2,...) passa
%   i parametri addizionali P1,P2,... alla funzione
%   ODEFUN come ODEFUN(T,Y,P1,P2...).
tt=linspace(tspan(1),tspan(2),Nh+1);
y=y0(:); % genera sempre un vettore colonna
u=y.';
global glob_h glob_t glob_y glob_odefun;
glob_h=(tspan(2)-tspan(1))/Nh;
glob_y=y;
glob_odefun=odefun;
glob_t=tt(2);
if ( exist('OCTAVE_VERSION') )
o_version=OCTAVE_VERSION;
version=str2num([o_version(1),o_version(3),o_version(5)]);
end

if ( ~exist('OCTAVE_VERSION') | version >= 320 )
options=optimset;
options.Display='off';
options.TolFun=1.e-12;
options.MaxFunEvals=10000;
end
for glob_t=tt(2:end)
if ( exist('OCTAVE_VERSION') & version < 320 )
 w = fsolve('beulerfun',glob_y);
else
  w = fsolve(@(w) beulerfun(w),glob_y,options);
end
  u = [u; w.'];
  glob_y = w;
end
t=tt';
clear glob_h glob_t glob_y glob_odefun;
end

function [z]=beulerfun(w)
  global glob_h glob_t glob_y glob_odefun;
  z=w-glob_y-glob_h*feval(glob_odefun,glob_t,w);
end
