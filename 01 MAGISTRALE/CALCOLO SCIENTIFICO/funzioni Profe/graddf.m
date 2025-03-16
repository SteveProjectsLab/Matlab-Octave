function [DX,DY]=graddf(xa,xb,ya,yb,n,m)
% matrici delle derivate parziali calcolate con diff. finite centrate
% su (xa,xb) x (ya,yb), n x m pixel

% matrice Dx
hx=(xb-xa)/(n-1); e=ones(n,1); 
dx=spdiags([-e,e],[-1,1],n,n);
% sistemo prima e ultima riga
dx(1,1:3)=[-3,4,-1]; dx(n,n-2:n)=[1,-4,3]; dx=dx/(2*hx);
DX=kron(speye(m),dx);

% matrice Dy
hy=(yb-ya)/(m-1); e=ones(m,1); 
dy=spdiags([-e,e],[-1,1],m,m);
% sistemo prima e ultima riga
dy(1,1:3)=[-3,4,-1]; dy(m,m-2:m)=[1,-4,3]; dy=dy/(2*hy);
DY=kron(dy,speye(n));

 
