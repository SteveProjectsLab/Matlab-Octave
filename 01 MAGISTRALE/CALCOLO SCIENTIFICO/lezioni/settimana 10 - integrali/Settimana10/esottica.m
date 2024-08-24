% esottica
% dati
xa=3e-4; xb=14e-4;
f=@(x)2.39e-11./(x.^5.*(exp(1.432./(213*x))-1));
% discretizzazione: 51 punti
x=linspace(xa,xb,51);
% valuto f
y=f(x);
% approssimo l'integrale con trapezi composita
It=trapz(x,y)
% stimo l'errore
H=(xb-xa)/50;
% valuto max |f''|
syms x
fs=2.39e-11./(x.^5.*(exp(1.432./(213*x))-1));
fs2=diff(fs,2);
f2=matlabFunction(fs2);
% figure(1); clf
% fplot(f2,[xa,xb])
% vettore di punti abbastanza fitti per valutare  max |f''|
x1=linspace(xa,xb,1000);
y2=f2(x1);
maxf2=norm(y2,'inf');
% maxf2=max(abs(y2))

stima=(xb-xa)/12*H^2*maxf2

%% punto 3 dell'esercizio
% calcolo H^* che garantisca errore <= 1e-10
Hstar=sqrt(12e-10/((xb-xa)*maxf2))

% il numero di intervallini da usare e'
Mstar=ceil((xb-xa)/Hstar)


