clear all
close
clc
%set(0,'DefaultFigureWindowStyle','docked')

% devo trovare le radici del seguente sistema di funzioni non lineari

f1=@(x1,x2)x1.^2-x2.^2-1;
f2=@(x1,x2)x1.^2+x2.^2-2*x1-3;
[x,y]=meshgrid(-3:0.1:3);

z1=f1(x,y);
z2=f2(x,y);

% rappresento la prima funzione
figure(1)
subplot(2,2,1);
meshc(x,y,z1);hold on;
contour(x,y,z1,[0,0],'LineWidth',2,'color','k')
xlabel('x1')
ylabel('x2')
title('f_1(x_1,x_2)')

%rappresento la seconda funzione
subplot(2,2,2);
meshc(x,y,z2);hold on;
contour(x,y,z2,[0,0],'LineWidth',2,'color','k')
xlabel('x1')
ylabel('x2')
title('f_2(x_1,x_2)')

% rappresento i contorni delle due funzioni a quota z=0 per individuare le
% intersezioni graficamente


subplot(2,2,3);
contour(x,y,z1,[0,0],'Linewidth',2,'color','b') % rappresento la contour a quota 0
hold on
contour(x,y,z2,[0,0],'Linewidth',2,'color','r') % rappresento la contour a quota 0
xlabel('x_1')
ylabel('x_2')
axis equal
grid on

%% --------------------------------------------------------------------------

% ora devo trovare numericamente le soluzioni
% calcolo la jacobiana
% syms x1 x2
% f_s=[x1^2-x2^2-1;
%        x1^2+x2^2-2*x1-3];
% Jf_s=jacobian(f_s,[x1,x2])
% % Jf =
% % [    2*x1, -2*x2]
% % [2*x1 - 2,  2*x2]

% definisco la funzione vettoriale
f=@(x)[x(1)^2-x(2)^2-1;
       x(1)^2+x(2)^2-2*x(1)-3];
% definisco la matrice Jacobiana
Jf=@(x)[2*x(1), -2*x(2);
        2*x(1)-2, 2*x(2)];


x0=[1;1]; % punto iniziale

tol=1e-6;
kmax=50;

[zero1,res1,k1,ERR1]=newtonsys(f,Jf,x0,tol,kmax)
plot(zero1(1),zero1(2),'o','MarkerFaceColor','k')
%Il metodo converge in 6 iterazioni con un residuo pari a 4.440892e-16
% zero1 =
%     2.0000
%     1.7321
% 
% res1 =   4.4409e-16
% 
% k1 =     6

x0=[1;-2];
 [zero2,res2,k2,ERR2]=newtonsys(f,Jf,x0,tol,kmax)
 plot(zero2(1),zero2(2),'o','MarkerFaceColor','k') % convergenza alla radice in basso a  destra

% guarda output

x0=[-2;-1];
[zero3,res3,k3,ERR3]=newtonsys(f,Jf,x0,tol,kmax)
plot(zero3(1),zero3(2),'o','MarkerFaceColor','k') % convergenza alla radice di sinistra

% guarda output

%--------------------------------------------------------------------------

% devo rappresentare gli errori
subplot(2,2,4)
semilogy((0:k1)',ERR1,'Linewidth',2,'Displayname','radice in alto a dx')
legend('-dynamiclegend')
hold on
semilogy((0:k2)',ERR2,'Linewidth',2,'Displayname','radice in basso a dx')
semilogy((0:k3)',ERR3,'Linewidth',2,'Displayname','radice a sx')
grid on
xlabel('k')
ylabel('errori')


%% --------------------------------------------------------------------------

% posso utilizzare il metodo di Broyden, che non è altro che il metodo di
% Newton generalizzato
B0=eye(2)

fprintf('utilizzo il metodo di Broyden\n')
x0=[1;1]; 
[ZERO,RES,NITER,ERR]=broyden(f,B0,x0,tol,kmax) 



% ZERO =
%     2.0000
%    -1.7321
% RES =
%    5.1556e-08
% NITER =
%     14
ERR(end)    %   2.0552e-07


% confronto con il metodo di newton
% zero1 =
%     2.0000
%     1.7321
% 
% res1 =   4.4409e-16
% 
% k1 =     6

%NB osservo che Newton ha un residuo minore rispetto a Broyden

% ripeto per le altre radici

%% --------------------------------------------------------------------------
% provo a risolvere con matlab

syms x1 x2
f_s=[x1^2-x2^2-1;
        x1^2+x2^2-2*x1-3];
zero_s=solve(f_s,[x1 x2])
zero1=double([zero_s.x1(1) zero_s.x2(1)])
zero2=double([zero_s.x1(2) zero_s.x2(2)])
zero2=double([zero_s.x1(3) zero_s.x2(3)])

% zero1 =
%     -1     0
% zero2 =
%    2.0000e+00   1.7321e+00
% zero2 =
%    2.0000e+00  -1.7321e+00


