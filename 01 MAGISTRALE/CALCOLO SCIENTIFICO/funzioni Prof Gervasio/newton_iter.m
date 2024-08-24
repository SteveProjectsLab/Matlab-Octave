function [zero,res,niter,xv]=newton_iter(fun,dfun,x0,tol,...
                                 nmax,varargin)
%NEWTON_ITER Trova uno zero di una funzione.
%   zero=newton_iter(fun,dfun,x0,tol,nmax) Approssima lo
%   zero ZERO della funzione definita nella function
%   FUN, continua e derivabile, usando il metodo di
%   Newton e partendo da X0. FUN e la sua derivata
%   DFUN accettano in ingresso uno scalare x e
%   restituiscono un valore scalare. Se la ricerca
%   dello zero fallisce, il programma restituisce un
%   messaggio d'errore. FUN e DFUN possono essere
%   inline function, anonymous function o function
%   definite in M-file.
%   zero=newton_iter(fun,dfun,x0,tol,nmax,p1,p2,...) passa
%   i parametri P1,P2,... alle funzioni
%   FUN(X,P1,P2,...) e DFUN(X,P1,P2,...).
%   [zero,res,niter,xv]=newton_iter(fun,...) restituisce il
%   valore del residuo RES in ZERO, il numero di
%   iterazioni NITER necessario per calcolare ZERO ed
%   il vettore XV contenente gli elementi della successione
%   {x^(k)} di Newton

x = x0;
xv=[x];
fx=fun(x,varargin{:});
dfx=dfun(x,varargin{:});
niter = 0; diff = tol+1;
while diff >= tol & niter < nmax
   niter = niter + 1;      diff = - fx/dfx;
   x = x + diff;           diff = abs(diff);
fx=fun(x,varargin{:});
dfx=dfun(x,varargin{:});
xv=[xv;x];
end
if (niter==nmax & diff > tol)
  fprintf(['Newton si e'' arrestato senza aver ',...
    'soddisfatto l''accuratezza richiesta, avendo\n',...
    'raggiunto il massimo numero di iterazioni\n']);
end
zero = x; res = fx;

return
