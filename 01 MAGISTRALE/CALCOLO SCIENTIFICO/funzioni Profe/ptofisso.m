function [alpha,k,xv,errv]=ptofisso(phi,x0,tol,...
                                 kmax,varargin)
%PTOFISSO Trova un punto fisso di una funzione.
% [alpha,k,xv,errv]=ptofisso(phi,x0,tol, kmax)
% Input: phi: funzione di cui si cerca punto fisso
%        x0: dato iniziale
%        tol: tolleranza per il test d'arresto (sulle iterate)
%        kmax: massimo numero di iterazioni
% Output: alpha: approssimazione del punto fisso
%         k: iterazioni effettuate per arrivare a convergenza 
%         xv: vettore con gli elementi della successione generata
%         errv: vettore con gli errori sull'incremento
%   

x = x0;
xv=[x0];
k = 0; err = tol+1;errv=[err];

while err >= tol & k < kmax
   k = k + 1;  
   xnew=phi(x,varargin{:});    
   err=abs(xnew-x); errv=[errv;err];
   x=xnew;
   xv=[xv;xnew];
end
if (k==kmax & err > tol)
  fprintf(['L`algoritmo si e'' arrestato senza aver ',...
    'soddisfatto l''accuratezza richiesta, avendo\n',...
    'raggiunto il massimo numero di iterazioni\n']);
end
alpha = x; 
return
