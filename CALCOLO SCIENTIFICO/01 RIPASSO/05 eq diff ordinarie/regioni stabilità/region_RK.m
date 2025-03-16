%Computation of the A-Stability Region of RK methods
%https://people.dm.unipi.it/meini/ODE12/lab6.html
% La frontiera della regione di stabilita' assoluta viene disegnata
% calcolando la funzione Psi(z), tale che x_{i+1}=Psi(z)x_i, in 
% punti z di un opportuno rettangolo del piano complesso, e 
% disegnando i punti z tali che |Psi(z)|=1

clear, clf reset
x=linspace(-3,1.5,200);
y=linspace(-3.5,3.5,200);
[X,Y]=meshgrid(x,y);
Z=X +Y*i;
% Metodo di Eulero
M=abs(1+Z);
[c,h]=contour(X,Y,M,[1,1]);
set(h,'linewidth',2,'edgecolor','g')

hold on
%Metodo di Heun
M=abs(1+Z/2.*(2+Z));
[c,h]=contour(X,Y,M,[1,1]);
set(h,'linewidth',2,'edgecolor','r')

%RK4
M=abs(1+Z.*(1+ Z.*(1/2+Z.*(1/6+Z/24))));
[c,h]=contour(X,Y,M,[1,1]);
set(h,'linewidth',2,'edgecolor','k')

%RKF4
M=abs(1+Z.*(1+Z/2.*(1+Z/3.*(1+Z/4.*(1+Z/(13/3))))));
[c,h]=contour(X,Y,M,[1,1]);
set(h,'linewidth',2,'edgecolor','b')

plot([-4 1.5],[0 0 ],'-b')
plot([0 0],[-3.5 3.5],'-b')
grid on
axis equal
title('Runge-Kutta A-Stability Regions')
legend('Eulers Method', 'Heuns Method','RK4','RKF4')