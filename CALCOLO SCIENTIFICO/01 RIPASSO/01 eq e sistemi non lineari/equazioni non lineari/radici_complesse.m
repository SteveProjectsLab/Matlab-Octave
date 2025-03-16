clear 
close all
clc

f=@(x)x^2-3*x+4
fplot(f,[-3,3]);mygrid();
df=matlabFunction(diff(sym(f),1))

% dal grafico vedo che non interseca lo zero

% non avrò soluzioni reali

%--------------------------------------------------------------------------
% provo lo stesso con fzero

% NB matlab mette  adisposizione una funzione per trovare gli zeri di una
% funzione, però trovo SOLO quelli reali
[x,fval,exitflag,output]=fzero(f,0)
% exitflag è <1, ciò vuol dire che non ha trovato uno zero reale

%--------------------------------------------------------------------------
% provo ad applicare Newton
pause;clc;
tol=1e-8
kmax=100
x0=1+i;
[zero,res,niter,ERR]=newton(f,df,x0,tol,kmax)

% ho trovato una radice complessa

% zero =   1.5000 + 1.3229i
% res =   4.4409e-16
% niter =     5

%--------------------------------------------------------------------------
% provo con il metodo delle Secanti
pause;clc;
x0=1+i;
x1=1;

[zero,res,niter,ERR]=secant(f,x0,x1,tol,kmax)
% anche il metodo delle secanti funziona bene