clear 
close all
clc
set(0,'DefaultFigureWindowStyle','docked')


% devo trovare il minimo della funzione
h=@(x)(x-5).^2-3*sin(x-5)
dh=matlabFunction(diff(sym(h),1))
ddh=matlabFunction(diff(sym(h),2))

% dh =    @(x)x.*2.0-cos(x-5.0).*3.0-1.0e+1
% ddh =   @(x)sin(x-5.0).*3.0+2.0

fplot(h,[0 10],'DisplayName','h');hold on;grid on;mygrid();
fplot(dh,[0 10],'DisplayName','dh');hold on;
fplot(ddh,[0 10],'DisplayName','ddh');hold on;
legend
%--------------------------------------------------------------------------
% devo valutare i punti stazionari della ddh

tol=1e-8
kmax=100
x0=0;
[zero,res,niter,ERR]=newton(dh,ddh,x0,tol,kmax)
plot(zero,res,'o','MarkerFaceColor','r');hold on;

% zero =     5.914856478447236e+00
% res =    -1.776356839400250e-15
% niter = 7
%--------------------------------------------------------------------------
%% ripeto come da consegna con x0b=1

tol=1e-8
kmax=100
x0b=5;
[zerob,resb,niterb,ERRb]=mynewton(dh,ddh,x0b,tol,kmax)
plot(zerob,resb,'o','MarkerFaceColor','r');

% zerob =     5.914856478447236e+00
% resb =    -1.776356839400250e-15
% niterb= 17


% partendo da x0 ci metto molte iterazioni rispetto a x0b
