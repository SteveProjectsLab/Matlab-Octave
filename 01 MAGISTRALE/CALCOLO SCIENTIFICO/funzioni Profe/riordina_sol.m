function [x,y,uh]=riordina_sol(nx,ny,u);
% [x,y,uh]=riordina_sol(nx,ny,u);
hx=1/(nx+1);hy=1/(ny+1);
x1=linspace(0,1,nx+2);
y1=linspace(0,1,ny+2);
[x,y]=meshgrid(x1,y1);
N=(nx+2)*(ny+2);
u0=zeros(N,1);
bordo=[1:nx+2,2*(nx+2):nx+2:N, N-(nx+1):N,nx+3:nx+2:N];
interni=[];
for j=2:ny+1
    interni=[interni,(nx+2)*(j-1)+2:(nx+2)*j-1];
end
interni=interni';

u0(interni)=u;
uh=converti(u0,nx+2,ny+2);


function [uh]=converti(u,nx,ny)
for i=1:nx
for j=1:ny
uh(j,i)=u((j-1)*nx+i);
end
end

