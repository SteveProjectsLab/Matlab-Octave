set(0,'DefaultFigureWindowStyle','docked')
clear all
close 
clc
% dati
m= 15 %kg
k= 17000 %N/m
v=0.05 %fattore smorzamento
%p1= 8*(pi*t/0.6) %forzante esterna per 0<=t<=0.6
p2= 0 %forzante esterna per t>0.6
w0= sqrt(k/m) %pulsazione propria
wd= w0*sqrt(1-v^2) %pulsazione propria sistema smorzato
w= pi/0.6 %pulsazione forzante
z= 2*v*w0*m %smorzamento

syms v(t)
Dv = diff(v);

odeforzata = m*diff(v,t,2) +z*diff(v,t,1)+k*v== 8*sin(pi*t/0.6);
cond1 = v(0) == 0;
cond2 = Dv(0) == 0;

conds = [cond1 cond2];
vSol(t) = dsolve(odeforzata,conds);
vSol = simplify(vSol)
figure(1)
fplot(vSol,[0,0.6],'DisplayName','forzante presente')
g=matlabFunction(vSol)
% ora la forzante vale 0
odelibera = m*diff(v,t,2) +z*diff(v,t,1)+k*v== 0;

cond3 = v(0.6) == vSol(0.6);
cond4 = Dv(0.6) == vSol(0.6);

conds2 = [cond3 cond4];
vSol1(t) = dsolve(odelibera,conds2);
vSol1 = simplify(vSol1)
hold on
fplot(vSol1,[0.6,2],'DisplayName','forzante a zero')
grid on
legend('-dynamicLegend')