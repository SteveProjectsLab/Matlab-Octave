close all
h=@(x)(x-5).^2-3*sin(x-5);
h1=@(x)2*(x-5)-3*cos(x-5);

% figure(1);clf
% fplot(h1,[0,10],'Linewidth',2)
% grid on
% xlabel('x')
% ylabel('h(x)')

f=h1;
df=@(x)2+3*sin(x-5);
x0=0; tol=1e-8; kmax=50;
[zero,res,k]=newton_did(f,df,x0,tol,kmax,0,10)
hold on
plot(zero,res,'ro')
x0=1; tol=1e-8; kmax=50;
[zero,res,k]=newton_did(f,df,x0,tol,kmax,-80,80)
plot(zero,res,'b*')