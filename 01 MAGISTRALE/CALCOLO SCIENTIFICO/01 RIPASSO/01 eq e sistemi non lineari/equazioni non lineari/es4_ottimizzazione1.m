clear
close all
clc

b=@(t)2500/(1+9*exp(-t/3))
db=matlabFunction(diff(sym(b),1))
%db=@(t)exp(t.*(-1.0./3.0)).*1.0./(exp(t.*(-1.0./3.0)).*9.0+1.0).^2.*7.5e+3

% è richiesto di trovare il massimo tasso di crescita della popolazione
% devo valutare db nei suoi punti stazionari, ovvero quando ddb=0
ddb=matlabFunction(diff(sym(db),1))
%ddb=@(t)exp(t.*(-1.0./3.0)).*1.0./(exp(t.*(-1.0./3.0)).*9.0+1.0).^2.*-2.5e+3+exp(t.*(-2.0./3.0)).*1.0./(exp(t.*(-1.0./3.0)).*9.0+1.0).^3.*4.5e+4

figure(1)
%fplot(b,[0 20],'Displayname','b(x)');hold on;grid on;
fplot(db,[0 20],'Displayname','db(x)');hold on;grid on;
fplot(ddb,[0 20],'Displayname','ddb(x)');hold on;grid on;
legend

% cerco lo zero in ddb
x0=5.5
x1=6.5
tol=1e-8
kmax=50;
[zero,res,it]=secanti(ddb,x0,x1,tol,kmax)
%plotto la soluzione
hold on
plot(zero,res,'or','Markerfacecolor','r')

