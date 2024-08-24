function [tn,un]=metodo2(odefun,tspan,y0,Nh, varargin)
%   [tn,un]=metodo2(odefun,tspan,y0,Nh);
%   approssimazione del problema di Cauchy del primo ordine
%   in forma vettoriale.
%   tspan = [t0,T] integra il sistema di equazioni
%   differenziali y' = f(t,y) dal tempo t0 a T con
%   condizione iniziale y0 
%   La funzione ODEFUN(T,Y) deve ritornare un vettore
%   contenente f(t,y), della stessa dimensione di y.
%   Ogni riga del vettore soluzione un corrisponde ad
%   un istante temporale del vettore colonna tn.


if nargin == 4
tol=1.e-8;nmax=20;pflag=0;
else
    tol=varargin{1};
    nmax=varargin{2};
    pflag=0;
end

t0=tspan(1);
T=tspan(2);
tn=linspace(t0,T,Nh+1)';
% calcolo h
h=(T-t0)/Nh;


y0=y0(:); % y0 sara' sempre vettore colonna
d=length(y0); % d= num. di eqz del sistema

% costruisco il vettore della soluzione numerica
un=zeros(Nh+1,d);

un(1,:)=y0.'; % .' realizza la trasposta sia che la variabile sia reale,
%                    sia che la variabile sia complessa
h2=h/2;
B0=eye(d);
n=1;
w=un(1,:)';
F=@(x)x-w-h2*(odefun(tn(n),w)+odefun(tn(n+1),x));
[w1]=cc(F,B0,w,tol,nmax,pflag);
un(2,:)=w1.';

for n=2:Nh
    w=un(n,:).';
    F=@(x)x-w-h2*(odefun(tn(n),w)+odefun(tn(n+1),x));
    [w1]=cc(F,B0,w,tol,nmax,pflag);
    un(n+1,:)=w1.';
end
function [zero,res,niter,err]=cc(fun,B0,x0,varargin)

if nargin==3
    tol=1.e-8; nmax=50; pflag=1;
elseif nargin==5
    tol=varargin{1};
    nmax=varargin{2};
    pflag=1;
else 
    tol=varargin{1};
    nmax=varargin{2};
    pflag=varargin{3};
end
fx0 = fun(x0);
niter = 0; 
err = tol+1;
Err=[err];
while err >= tol && niter < nmax
s=-B0\fx0; 
x1=x0+s; 
fx1=fun(x1);
B0=B0+(fx1*s')/(s'*s);
niter = niter + 1; 
err = norm(s);
Err=[Err;err];
x0=x1; fx0=fx1;
end
zero = x1; res = norm(fx1);
if pflag
if (niter==nmax && err > tol)
  fprintf(['il metodo si e'' arrestato senza aver ',...
   'soddisfatto l''accuratezza richiesta, avendo\n',...
   'raggiunto il massimo numero di iterazioni\n']);
else
    fprintf(['Il metodo converge in %i iterazioni',...
            ' con un residuo pari a %e\n'],niter,res);
end
end
return




