%Computation of the A-Stability Region of explicit Adams-Moulton metohds
clear, clf reset

% la matrice beta contiene, sulla riga k, i coefficienti beta_i del metodo
% a k passi, completati con zeri fino a 6
beta=zeros(6);
% metodo di eulero
beta(1,1)=1; 
% metodo a 2 passi
beta(2,1:2)=[3, -1]/2;
% metodo a 3 passi
beta(3,1:3)=[23, -16, 5]/12;
% metodo a 4 passi
beta(4,1:4)=[55, -59, 37, -9]/24;
% metodo a 5 passi
beta(5,1:5)=[1901, -2774, 2616, -1274, 251]/720;
% metodo a 6 passi
beta(6,1:6)=[4277, -7923, 9982, -7298, 2877, -475]/1440;

% La frontiera della regione di stabilita' assoluta viene disegnata
% disegnando i punti z=rho(om)/sigma(om), al variare di om sulla
% circonferenza unitaria, dove rho(.) e sigma(.) sono i 2 polinomi
% associati al LMM
r=[0:200];
om=cos(2*pi/200*r)+i*sin(2*pi/200*r);
z=(om-1)./(polyval([beta(1,1)],om));
plot(z,'r.')
hold on
z=(om.^2-om)./(polyval([beta(2,1:2)],om));
plot(z,'g.')
z=(om.^3-om.^2)./(polyval([beta(3,1:3)],om));
plot(z,'b.')
z=(om.^4-om.^3)./(polyval([beta(4,1:4)],om));
plot(z,'k.')
z=(om.^5-om.^4)./(polyval([beta(5,1:5)],om));
plot(z,'y.')
%z=(om.^6-om.^5)./(polyval([beta(6,1:6)],om));
%plot(z,'c.')

grid on
axis equal
plot([-2.5 1.2],[0 0 ],'-k')
plot([0 0],[-2 2],'-k')

legend('k=1','k=2','k=3','k=4','k=5')
title('Metodi espliciti di Adams-Moulton, Stability Regions')