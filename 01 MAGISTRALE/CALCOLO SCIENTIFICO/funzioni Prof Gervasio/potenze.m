function [lambda,y,iter,lambdav,errv]=potenze(A,tol,nmax,x0)
%POTENZE    Approssima l'autovalore di modulo massimo
%            di una matrice.
% [lambda,y,iter,lambdav,errv]=potenze(A,tol,nmax,x0)
% Input: A matrice quadrata
%        tol  tolleranza per il test d'arresto
%        nmax numero massimo di iterazioni
%        x0 vettore iniziale per il metodo
% Output: lambda autovalore approssimato di modulo massimo
%         y autovettore associato a lambda
%         lambdav vettore delle iterate lambda^(k)
%         vettore degli errori usati nel test d'arresto
%
[n,m] = size(A);
if n ~= m, error('Solo per matrici quadrate'); end
if nargin == 1
   tol = 1.e-06;   x0 = ones(n,1);   nmax = 100;
end
y = x0/norm(x0);
ay = A*y;
lambda = y'*ay;
err = tol*abs(lambda) + 1;
lambdav=[lambda];
errv=[err];
iter = 0;
while err>tol &  iter<=nmax
   x = ay;              y = x/norm(x);
   ay = A*y;            lambdanew = y'*ay;
   err = abs(lambdanew - lambda)/abs(lambdanew);
   lambda = lambdanew;   iter = iter + 1;
   lambdav=[lambdav;lambda];
   errv=[errv;err];
end
return
