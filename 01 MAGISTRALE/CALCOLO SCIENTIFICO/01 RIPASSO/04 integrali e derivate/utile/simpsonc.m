function [Isic]=simpsonc(f,a,b,M)
%SIMPSONC Formula composita di Simpson
%   isic = simpsonc(fun,a,b,M) calcola una
%   approssimazione dell'integrale della funzione
%   FUN tramite la formula composita di Simpson
%   (su M intervalli di uguale ampiezza). FUN e' una
%   function che riceve in ingresso un vettore reale x
%   e restituisce un vettore reale.
%   FUN puo' essere una inline function, una anonymous
%   function o una function definita in un M-file.
H=(b-a)/M;
x=linspace(a,b,M+1);
Isic=0;
for k=1:M
xm=(x(k)+x(k+1))/2;
Isic=Isic+(f(x(k))+4*f(xm)+f(x(k+1)));
end
Isic=Isic*H/6;

return

