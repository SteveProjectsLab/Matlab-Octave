clear all
close
clc

set(0,'DefaultFigureWindowStyle','docked')

f1=@(x)1/3*log(x/2)+x.^2
f2=@(x)x.^2+x-1

f=@(x) f1(x)-f2(x)
df=matlabFunction(diff(sym(f),1))
%df=@(x)1.0./(x.*3.0)-1.0

fplot(f,[0.4 0.8],'DisplayName','f');hold on;
fplot(f1,[0.4 0.8],'DisplayName','f1');hold on;
fplot(f2,[0.4 0.8],'DisplayName','f2');hold on;
grid on;

line(xlim,[0 0],'color','k','DisplayName','x')
%line([0 0],ylim,'color','r','DisplayName','y')

legend('-dynamicLegend')
tol=1e-8;
kmax=100;
%%
%trovo l'intersezione con bisezione
a=0.5;
b=0.7;

 [zero, k, res]=bisezione(f,a,b,tol,kmax)
 kmin_teorico=ceil(log2((b-a)/tol)-1)
 plot(zero,f1(zero),'o','DisplayName','radiceBisezione','MarkerFaceColor','r')

% zero =    0.5970
% k =    24
% res =   9.1526e-11
% kmin_teorico =    24

%%
% trovo l'intersezione con Newton
x0=0.6;
[zero,res,niter,ERR]=newton(f,df,x0,tol,kmax)
plot(zero,f1(zero),'o','DisplayName','radiceNewton','MarkerFaceColor','r')

% zero =    0.5970
% res =  -5.5511e-17
% niter =     3
% ERR =
%     1.0000
%     0.0030
%     0.0000
%     0.0000

