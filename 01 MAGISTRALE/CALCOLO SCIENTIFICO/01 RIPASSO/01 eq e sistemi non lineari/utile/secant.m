function [zero,res,niter,ERR]=secant(fun,x0,x1,tol,nmax)
%SECANT Trova uno zero di una funzione.
%   zero=secant(fun,x0,x1,tol,nmax) approssima lo
%   zero ZERO della funzione definita nella function
%   FUN, continua usando il metodo di secanti
%   partendo da X0 e X1. FUN accetta in ingresso
%   uno scalare x e restituisce un valore scalare.
%   Se la ricerca dello zero fallisce, il programma
%   restituisce un messaggio d'errore.
%   FUN puo' essere una inline function, anonymous
%   function o function definita in M-file.
%   [zero,res,niter,ERR]= secant(fun,...) restituisce il
%   valore del residuo RES in ZERO, il numero di
%   iterazioni NITER necessario per calcolare ZERO
%   e il vettore degli ERR degli incrementi: 
%   ERR(k)=|x^(k+1)-x^(k)|

niter = 0; 
err = tol+1;
ERR=[err];
fx0=fun(x0);
fx1=fun(x1); 

while err >= tol & niter < nmax
   xnew=x1-fx1*(x1-x0)/(fx1-fx0);
   niter = niter + 1; err = abs(xnew-x1);
   ERR=[ERR; err];
   x0=x1; x1 = xnew;
   fx0=fx1;  fx1=fun(x1);
end
if (niter==nmax && err > tol)
  fprintf(['Secanti si e'' arrestato senza aver ',...
   'soddisfatto l''accuratezza richiesta, avendo\n',...
   'raggiunto il massimo numero di iterazioni\n']);
end
zero = x1; res = fx1;
return
