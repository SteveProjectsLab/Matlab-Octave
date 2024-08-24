set(0,'DefaultFigureWindowStyle','docked');
clear all
close
clc

R=0.055;
rho=0.6;
tol=1.e-8;
kmax=100;



f=@(x) x.^3-3*x.^2*R+4*R^3*rho
x=linspace(-0.01,0.2,1000);

plot(x,f(x));myAxis;

hold on;
% dal grafico vedo che c'è uno zero tra 0.06 e 0.07
%%
scelta=menu('Scegli il metodo',...
            'bisezione',...
            'Newton',...
            'secanti');
%--------------------------------------------------------------------------
if scelta==1
    clc
    fprintf('metodo di bisezione\n')
    a=0.06;
    b=0.07

    [zero, k, res]=bisezione(f,a,b,tol,kmax)  
    % z =    0.0624
    % k =    23
    % res =   4.7070e-11
    plot(zero,res,'o','Markerfacecolor','r');
    fprintf('radice trovata in (%e,%e), con %d iterazioni, ',zero,res,k)
    % guardo se il numero di iterazioni compiute corrisponde 
    % con la teoria
    kmin_teorico=ceil(log2((b-a)/tol)-1)
    %kmin_teorico =    19
%--------------------------------------------------------------------------
elseif scelta ==2
    clc
    fprintf('metodo di Newton\n')
    syms x
    F=x^3-3*x^2*R+4*R^3*rho
    df =matlabFunction(diff(F,1))
    % df =    @(x)x.*(-3.3e+1./1.0e+2)+x.^2.*3.0
    x0=0;   % si blocca perch' f'(0)=0
    x0=0.03;
    %x0=0.01;
    [zero,res,niter,ERR]=mynewton(f,df,x0,tol,kmax)
    fprintf('radice trovata in (%e,%e), con %d iterazioni,\n commettendo un errore di %e',zero,res,niter,ERR(end))
    plot(zero, res, 'o','Markerfacecolor','r')
%--------------------------------------------------------------------------
elseif scelta ==3
    clc
    x0=0
    x1=0.05
    fprintf('metodo delle secanti\n')
    [zero,res,niter,ERR]=secant(f,x0,x1,tol,kmax)
    fprintf('radice trovata in (%e,%e), con %d iterazioni,\n commettendo un errore di %e',zero,res,niter,ERR(end))
    plot(zero, res, 'o','Markerfacecolor','r')
end
