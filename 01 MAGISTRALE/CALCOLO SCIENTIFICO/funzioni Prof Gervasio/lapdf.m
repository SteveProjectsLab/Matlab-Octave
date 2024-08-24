function [A]=lapdf(xa,xb,ya,yb,n,m)
% matrice del laplaciano diff finite centrate
% su (xa,xb) x (ya,yb), n x m pixel
hx=(xb-xa)/(n-1); hy=(yb-ya)/(m-1); 
alpha=-1/hy^2;
beta=-1/hx^2;
gam=2*(1/hx^2+1/hy^2);
N=n*n; e=ones(N,1); 
A=spdiags([alpha*e,beta*e,gam*e,beta*e,alpha*e],...
[-n,-1,0,1,n],N,N);
