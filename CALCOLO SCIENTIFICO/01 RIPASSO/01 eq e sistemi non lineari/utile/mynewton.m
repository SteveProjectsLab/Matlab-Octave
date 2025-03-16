function [zero,res,niter,ERR]=mynewton(fun,dfun,x0,tol,nmax)
%NEWTON Trova uno zero di una funzione.
%   zero=newton(fun,dfun,x0,tol,nmax) approssima lo
%   zero ZERO della funzione definita nella function
%   FUN, continua e derivabile, usando il metodo di
%   Newton e partendo da X0. FUN e la sua derivata
%   DFUN accettano in ingresso uno scalare x e
%   restituiscono un valore scalare. Se la ricerca
%   dello zero fallisce, il programma restituisce un
%   messaggio d'errore. FUN e DFUN possono essere
%   inline function, anonymous function o function
%   definite in M-file.
%   [zero,res,niter,err]= newton(fun,...) restituisce il
%   valore del residuo RES in ZERO, il numero di
%   iterazioni NITER necessario per calcolare ZERO
%   e il vettore degli ERR degli incrementi: 
%   ERR(k)=|x^(k+1)-x^(k)|

x = x0;
niter = 0; err = tol+1; ERR=[err];
while err >= tol && niter < nmax
   xnew=x-fun(x)/dfun(x) ;
   err=abs(xnew-x);
   ERR=[ERR;err];
   niter = niter + 1;
   x = xnew;
end
if (niter==nmax && err > tol)
  fprintf(['Newton si e'' arrestato senza aver ',...
   'soddisfatto l''accuratezza richiesta, avendo\n',...
   'raggiunto il massimo numero di iterazioni\n']);
end
zero = x; res = fun(zero);
return

