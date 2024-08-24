function D=qrbasic(A,tol,nmax)
%QRBASIC calcola gli autovalori di una matrice
%  d=qrbasic(A,tol,nmax) Calcola con il metodo delle
%  iterazioni QR tutti gli autovalori della matrice A
%  a meno di una tolleranza TOL ed in un numero massimo
%  di iterazioni NMAX. La convergenza di questo metodo
%  non e' in generale garantita.
[n,m]=size(A);
if n ~= m
  error('La matrice deve essere quadrata')
end
T = A; niter = 0; test = norm(tril(A,-1),inf);
while niter <= nmax & test >= tol
  [Q,R]=qr(T);    T = R*Q;  niter = niter + 1;
%   if(rem(niter,20)==0 | niter==121)
%      niter
%      R 
%      Q
%      T
%      pause
%   end
  test = norm(tril(T,-1),inf);
end
if niter > nmax
 warning(['Il metodo non converge nel massimo',...
             ' numero di iterazioni permesso']);
else
 fprintf('Il metodo converge in %d iterazioni\n',niter)
end
D = diag(T);
return
