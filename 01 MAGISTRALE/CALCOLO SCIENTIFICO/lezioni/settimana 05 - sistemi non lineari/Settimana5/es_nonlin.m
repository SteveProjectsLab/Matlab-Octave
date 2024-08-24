% esercizio su sistemi non lineari
f1=@(x1,x2)x1.^2-x2.^2-1;
f2=@(x1,x2)x1.^2+x2.^2-2*x1-3;
% genero la mesh
[x,y]=meshgrid(-3:.1:3);
% valuto le due funzioni
z1=f1(x,y);
z2=f2(x,y);

figure(1); clf
subplot(2,2,1)  % alto sinistro
meshc(x,y,z1); % disegno la prima funzione
hold on
contour(x,y,z1,[0,0],'Linewidth',2,'color','b') % rappresento la contour a quota 0
xlabel('x_1')
ylabel('x_2')
title('f_1(x_1,x_2)')

subplot(2,2,2)  % alto destro
meshc(x,y,z2); % disegno la seconda funzione
hold on
contour(x,y,z2,[0,0],'Linewidth',2,'color','r') % rappresento la contour a quota 0
xlabel('x_1')
ylabel('x_2')
title('f_2(x_1,x_2)')

subplot(2,2,3) % basso sinistro
contour(x,y,z1,[0,0],'Linewidth',2,'color','b') % rappresento la contour a quota 0
hold on
contour(x,y,z2,[0,0],'Linewidth',2,'color','r') % rappresento la contour a quota 0
xlabel('x_1')
ylabel('x_2')
axis equal
grid on






%% script per richiamre newtonsys
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
figure(1);
subplot(2,2,3)
plot(zero1(1),zero1(2),'ko')  % convergenza alla radice in alto a destra

x0=[1;-2];
 [zero2,res2,k2,ERR2]=newtonsys(f,Jf,x0,tol,kmax)
 plot(zero2(1),zero2(2),'m*') % convergenza alla radice in basso a  destra

x0=[-2;-1];
[zero3,res3,k3,ERR3]=newtonsys(f,Jf,x0,tol,kmax)
plot(zero3(1),zero3(2),'cs') % convergenza alla radice di sinistra

% disegno i vettori degli errori nel subplot 4
subplot(2,2,4)
semilogy((0:k1)',ERR1,'Linewidth',2,'Displayname','radice in alto a dx')
legend('-dynamiclegend')
hold on
semilogy((0:k2)',ERR2,'Linewidth',2,'Displayname','radice in basso a dx')
semilogy((0:k3)',ERR3,'Linewidth',2,'Displayname','radice a sx')
grid on
xlabel('k')
ylabel('errori')