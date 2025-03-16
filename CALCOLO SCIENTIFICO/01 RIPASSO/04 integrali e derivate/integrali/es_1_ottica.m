clear all
close all
clc
% esottica
% dati
xa=3e-4; xb=14e-4;
% devo calcolare numericamente l'integrale di questa funzione

f=@(x)2.39e-11./(x.^5.*(exp(1.432./(213*x))-1));


x=linspace(xa,xb,51);% discretizzazione: 51 punti
y=f(x);% valuto f nei punti scelti
figure(1)
plot(x,y,'DisplayName','f(x)')
legend('-DynamicLegend')
% approssimo l'integrale con trapezi composita
It=trapz(x,y)

H=(xb-xa)/50;% stimo l'errore

% valuto max |f''|
f2=matlabFunction(diff(sym(f),2)); 
%%
figure(2); 
grid on
fplot(f2,[xa,xb],'DisplayName','f'''' '' (x)')
hold on
%vettore di punti abbastanza fitti per valutare  max |f''|
x1=linspace(xa,xb,1000);
y2=f2(x1);
%maxf2=norm(y2,'inf');
[maxf2,imax]=max(abs(y2));
plot((xb-xa)/1000*imax+xa,maxf2,'o','DisplayName','Max')
legend('-dynamicLegend')

stima=(xb-xa)/12*H^2*maxf2
% It =     2.069068361465305e-02
% stima =     1.129318297478365e-05
%% punto 3 dell'esercizio
% calcolo H^* che garantisca errore <= 1e-10
Hstar=sqrt(12e-10/((xb-xa)*maxf2))

% il numero di intervallini da usare e'
Mstar=ceil((xb-xa)/Hstar)


% Hstar =     6.546580287551752e-08
% Mstar =       16803

