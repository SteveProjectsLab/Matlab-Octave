f=@(x) x.^3-3*x.^2*R+4*R^3*rho
x=linspace(-0.01,0.2,1000);
tol=1.e-8;
kmax=100;

%% bisezione
[zero, k, res]=bisezione(f,a,b,tol,kmax)
 kmin_teorico=ceil(log2((b-a)/tol)-1)

%% newton
 f=@(x)sin(x-1)-0.5*sin(2*(x-1))
 df =matlabFunction(diff(sym(f),1))
 [zero,res,niter,ERR]=newton(f,df,x0,tol,kmax)

%% secanti
[zero,res,niter,ERR]=secant(f,x0,x1,tol,kmax)

%% rappresento gli errori in scala logaritmica
 % rappresento gli errori in scala logaritmica
 figure(2); clf
 semilogy((0:niter)',ERR1,'Displayname','errore sx')

 %% punto fisso

 % dire se è un'equazione di punto fisso
 phi1=@(x)x/2+1./x;

 phi1(sqrt(2))% 1.4142 ok   % ci sostituisco dentro il punto fisso
 
dphi1=matlabFunction(diff(sym(phi1),1));% osservo il modulo dele derivate in un intorno della radice
abs(dphi1(sqrt(2)))   % 0.2929

% osservo che |phi_1'(alpha)|< 1, quindi mi aspetto che il metodo di 
% punto fisso converga con ordine 1
% osservo che phi_2'(alpha)<-1, quindi non mi aspetto convergenza al punto
% fisso
% osservo che phi_3'(alpha)=0, quindi mi aspetto convergenza di ordine 2


[alpha1,niter1,xv1,errori1]=ptofisso(phi1,x0,tol,kmax)

%% ottimizzazione
b=@(t)2500/(1+9*exp(-t/3))

% devo trovare il massimo/ minimo
% guardo quando si annulla la derivata seconda
ddb=matlabFunction(diff(sym(b),2))
% cerco lo zero ( con un qualsiasi metodo)
[zero,res,it]=secanti(ddb,x0,x1,tol,kmax)

%% intersezione di due funzioni
f1=@(x)1/3*log(x/2)+x.^2
f2=@(x)x.^2+x-1

f=@(x) f1(x)-f2(x)
% devo trovare lo zero

%% radici di un polinomio

a=[1 -3 -3 7 6]% coefficienti del polinomio ( dal grado più alto)

x=roots(a)  % solo per radici reali

%% radici complesse
% non posso usare fzero()

%% sistemi non lineari

syms x1 x2
f_s=[x1^2-x2^2-1;
       x1^2+x2^2-2*x1-3];
Jf_s=jacobian(f_s,[x1,x2])


x0=[1;1]; % punto iniziale

tol=1e-6;
kmax=50;

[zero1,res1,k1,ERR1]=newtonsys(f,Jf,x0,tol,kmax)

% oppure
B0=eye(2)

fprintf('utilizzo il metodo di Broyden\n')
x0=[1;1]; 
[ZERO,RES,NITER,ERR]=broyden(f,B0,x0,tol,kmax) 

% oppure con Matlab
zero_s=solve(f_s,[x1 x2])
zero1=double([zero_s.x1(1) zero_s.x2(1)])
zero2=double([zero_s.x1(2) zero_s.x2(2)])
zero2=double([zero_s.x1(3) zero_s.x2(3)])