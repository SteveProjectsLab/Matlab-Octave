% es_robot

% dati
x=(-55:10:65)';
y=[3.7 3.7 3.52 3.27 3.2 3.15 3.15 3.25 3.47 3.52 3.65 3.62 3.52 ]';
np=length(x);
n=np-1;
% definisco un vettore di punti piu' fitti
x1=linspace(x(1),x(end),500);

% interpolazione globale di Lagrange
% 1. calcolo il vett dei coeff con polyfit
% grado n = numero di punti meno 1
% a=polyfit(x,y,n);   

% 2. calcolo il vettore dei coefficienti del polinomio di interp. globale con
% la costruzione esplicita della matrice di VanderMonde
% X=vander(x);
% a=X\y;

% valuto il polinomio trovato  (nei casi 1 e 2)
% y1=polyval(a,x1);

% 3. calcolo il polinomio di interp gloabale di Lagrange con barycentric
% (sviluppo il polinomio rispetto alla base di Lagrange)
y1=barycentric(x,y,x1);

% disegno
figure(1); clf
plot(x,y,'o','DisplayName','dati')
legend('-dynamiclegend')
hold on
plot(x1,y1,'Linewidth',2,'DisplayName','Lagrange globale')
grid on
xlabel('L')
ylabel('Delta T')

% costruisco l'interpolatore composito lineare
y1c=interp1(x,y,x1);
plot(x1,y1c,'LineWidth',2,'DisplayName','interp. composita')

% costruisco la spline cubica
s3=spline(x,y,x1);
plot(x1,s3,'LineWidth',2,'DisplayName','spline')


% valuto la Delta T a Roma (+42) e ad Oslo(+59)

x2=[42,59];
% valori calcolati con itnerp. gloabel di Lagrange
y2=barycentric(x,y,x2);
fprintf('interp. globale: Roma=%f Oslo=%f\n',y2)
% interpolazione composita
y2c=interp1(x,y,x2);
fprintf('interp. composita: Roma=%f Oslo=%f\n',y2c)
% interpolazione spline
ys2=spline(x,y,x2);
fprintf('interp. spline: Roma=%f Oslo=%f\n',ys2)










