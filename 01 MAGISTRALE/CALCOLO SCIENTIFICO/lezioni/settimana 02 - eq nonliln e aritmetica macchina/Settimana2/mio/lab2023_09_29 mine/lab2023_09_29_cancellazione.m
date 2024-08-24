clear
close all
clc

x=linspace(0.996,1.004,10000);

%NB: p1, p2 e p3 sono rappresentazioni equivalenti (su carta)
p1=(x-1).^6;
p2=x.^6-6*x.^5+15*x.^4-20*x.^3+15*x.^2-6*x+1;
p3=1+x.*(-6+x.*(15+x.*(-20+x.*(15+x.*(-6+x)))));

figure('Name','Errore di Cancelazione');

plot(x,p2,x,p3,x,p1);
l=legend('p2','p3','p1');
l.set('Location','SouthWest');
grid on
axis tight
xlabel('x');
ylabel('y');

%Rappresentazione corretta data da p1
%Gli altri due grafici presentano molte oscillazioni, date dalla
%cancellazione di cifre significative durante le somme -> Mostrano
%l'instabilità dell'operazione somma