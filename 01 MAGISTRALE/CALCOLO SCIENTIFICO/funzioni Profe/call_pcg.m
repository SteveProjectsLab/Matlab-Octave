rho=@(x,y)[exp(-120*((x-.25).^2+(y-.25).^2))+2*exp(-200*((x-.75).^2+(y-.75).^2))];

N=10:10:100;
it=[];it1=[];
err=[]; err1=[];
for nx=N
    ny=nx;
    clear A b
[A,b]=potenziale(nx,ny,rho);
n=nx*ny;
x0=zeros(n,1);
kmax=500;
tol=1.d-12;
R=cholinc(A,1.d-3);
[u,k,res,resvec]=pcg_gqs(A,b,x0,kmax,tol,R);
it=[it;k]; err=[err;res];
[u,flag,res1, k1,resvec1]= pcg(A,b,tol,kmax,R',R,x0);
it1=[it1;k1];err1=[err1;res1];
[x,y,uh]=riordina_sol(nx,ny,u);
% surf(x,y,uh); title(['nx=',num2str(nx)])
% pause
end
