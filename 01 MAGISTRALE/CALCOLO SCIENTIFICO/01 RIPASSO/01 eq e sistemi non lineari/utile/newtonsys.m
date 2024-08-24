function [x,res,niter,Err] = newtonsys(Ffun,Jfun,x0,tol,nmax)
%NEWTONSYS calcola una radice di un sistema non lineare
%   [zero,res,niter,Err]=newtonsys(Ffun,Jfun,x0,tol,nmax)
%   calcola il vettore ZERO, radice di un sistema non
%   lineare definito nella function FFUN con matrice
%   jacobiana definita nella function JFUN a partire
%   dal vettore colonna X0. RES contiene il valore del residuo
%   in ZERO e NITER il numero di iterazioni necessarie
%   per calcolare ZERO. FFUN e JFUN sono function-handle o
%   function definite in M-file.
%   Nel vettore ERR sono salvate le norme degli incrementi
%   alle varie iterazioni

x0=x0(:);
k = 0;
err = tol + 1;
x = x0;
Err=err;
while err >= tol && k < nmax
    A = Jfun(x);
    if det(A)==0
       disp('Il metodo si e` arrestato')
       res = [];  x= []; niter = k;
       return
    end	
    b = Ffun(x);
    z =  A\b;
    xnew = x - z;
    err = norm(z);
    Err=[Err;err];
    k = k + 1;
    x=xnew;
end
res = norm(Ffun(x));
niter=k;
if (niter==nmax & err> tol)
    fprintf(['Il metodo non converge nel massimo ',...
       'numero di iterazioni. L''ultima iterata\n',...
       'calcolata ha residuo relativo pari a %e\n'],res);
else
    fprintf(['Il metodo converge in %i iterazioni',...
            ' con un residuo pari a %e\n'],niter,res);
end
return
