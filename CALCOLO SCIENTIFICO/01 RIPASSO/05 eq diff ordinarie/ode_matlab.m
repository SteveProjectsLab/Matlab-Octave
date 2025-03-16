clear 
close all
clc
%% dy/dt=ty. equazione differenziale
syms y(t)
ode = diff(y,t) == t*y
ySol(t)=dsolve(ode) 
%ySol(t) =C1*exp(t^2/2) 

%% equazione differenziale con soluzione
syms y(t)
ode = diff(y,t) == t*y
cond = y(0) == 2;
ySol(t) = dsolve(ode,cond)
%ySol(t) =2*exp(t^2/2)

%% ridurre il grado di un'equazione lineare
syms y(t)
eqn = diff(y,2) + y^2*t == 3*t;
V = odeToVectorField(eqn)
% V =
%           Y[2]
% 3*t - t*Y[1]^2
%% sistema di equazioni differenziali
syms y(t) z(t)
eqns = [diff(y,t) == z, diff(z,t) == -y];
S = dsolve(eqns)
%% ed non lineare
syms y(t)
ode = (diff(y,t)+y)^2 == 1;
cond = y(0) == 0;
ySol(t) = dsolve(ode,cond)
%ySol(t) =
% exp(-t) - 1
% 1 - exp(-t)

%% edo 2° ordine con condizione iniziale
syms y(x)
Dy = diff(y);

ode = diff(y,x,2) == cos(2*x)-y;
cond1 = y(0) == 1;
cond2 = Dy(0) == 0;

conds = [cond1 cond2];
ySol(x) = dsolve(ode,conds);
ySol = simplify(ySol)

% ySol(x) =
% 1 - (8*sin(x/2)^4)/3
 
%% edo 3° ordine con condizione iniziale
syms u(x)
Du = diff(u,x);
D2u = diff(u,x,2);

ode = diff(u,x,3) == u;
cond1 = u(0) == 1;
cond2 = Du(0) == -1;
cond3 = D2u(0) == pi;
conds = [cond1 cond2 cond3];

uSol(x) = dsolve(ode,conds)
% uSol(x) =
% (pi*exp(x))/3 - exp(-x/2)*cos((3^(1/2)*x)/2)*(pi/3 - 1) - (3^(1/2)*exp(-x/2)*sin((3^(1/2)*x)/2)*(pi + 1))/3
