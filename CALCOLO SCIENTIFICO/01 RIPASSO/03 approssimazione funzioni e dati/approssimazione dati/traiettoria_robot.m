clear
close all
clc
% dati
x=[2.00 4.25 5.25 7.81 9.20 10.60]';
y=[7.2 7.1 6.0 5.0 3.5 5.0]';

%il robot deve rispettare determinati vincoli di movimento
%bisogna calcolare la traiettoria del robot (appx come punto materiale)
% devi scegliere tra tre appossimatori diversi;
% quale è il migliore per avere una traiettoria breve e regolare?

%% 1- interpolatore globale di Lagrange

% interpolazione globale di Lagrange
a=polyfit(x,y,5); % 5 perche' ho 6 punti
% grado n = numero di punti meno 1


x1=linspace(x(1),x(end),100);   % definisco un vettore di punti piu' fitti
y1=polyval(a,x1);   % valuto il polinomio trovato

% disegno
figure(1); clf
plot(x,y,'o','DisplayName','dati')
legend('-dynamiclegend')
hold on
plot(x1,y1,'Linewidth',2,'DisplayName','Lagrange globale')
grid on
xlabel('x')
ylabel('y')

%% 2- interpolatore composita lineare di Lagrange
pause
y1c=interp1(x,y,x1);
plot(x1,y1c,'LineWidth',2,'DisplayName','interp. composita')

%% 3- spline cubiche
pause
hold on
s3=spline(x,y,x1);
plot(x1,s3,'LineWidth',2,'DisplayName','spline')


% lagrange globale genera la traiettoria più lunga ma è la più regolare
% lagrange composito lineare genera la traiettoria più corta ma è solo C0
% la spline è un compromesso tra i due ed è di classe C2, non
% eccessivamente lunga
