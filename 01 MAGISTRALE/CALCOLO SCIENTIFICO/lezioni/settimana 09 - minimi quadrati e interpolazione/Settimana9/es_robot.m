% es_robot

% dati
x=[2.00 4.25 5.25 7.81 9.20 10.60]';
y=[7.2 7.1 6.0 5.0 3.5 5.0]';

% interpolazione globale di Lagrange
a=polyfit(x,y,5); % 5 perche' ho 6 punti
% grado n = numero di punti meno 1

% definisco un vettore di punti piu' fitti
x1=linspace(x(1),x(end),100);
% valuto il polinomio trovato
y1=polyval(a,x1);

% disegno
figure(1); clf
plot(x,y,'o','DisplayName','dati')
legend('-dynamiclegend')
hold on
plot(x1,y1,'Linewidth',2,'DisplayName','Lagrange globale')
grid on
xlabel('x')
ylabel('y')

% costruisco l'interpolatore composito lineare
y1c=interp1(x,y,x1);
plot(x1,y1c,'LineWidth',2,'DisplayName','interp. composita')

% costruisco la spline cubica
s3=spline(x,y,x1);
plot(x1,s3,'LineWidth',2,'DisplayName','spline')














