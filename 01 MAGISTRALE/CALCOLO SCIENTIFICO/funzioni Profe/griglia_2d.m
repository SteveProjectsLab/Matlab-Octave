function [xy]=griglia_2d(xa,xb,ya,yb,npx,npy)
%  griglia_2d genero griglia equispaziata in 2d
%  su Omega(xa,xb) x (ya,yb)
%  npx nodi in x, npy nodi in y
%
% [xy]=griglia_2d(xa,xb,ya,yb,npx,npy) 
 
N=npx*npy;
 

x=linspace(xa,xb,npx);
y=linspace(ya,yb,npy);
xy=zeros(N,2);
for j=1:npy
    for i=1:npx
        k=(j-1)*npx+i;
        xy(k,:)=[x(i),y(j)];
    end
end
