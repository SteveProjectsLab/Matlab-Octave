
%% approssimare i dati con vari metodi
x=[2.00 4.25 5.25 7.81 9.20 10.60]';
y=[7.2 7.1 6.0 5.0 3.5 5.0]';


% interpolatore globale di Lagrange (calcolando i coeffiecienti)
% calcolo i coefficienti

%-uso--Matlab--------------------------------------------------------------- 
a=polyfit(x,y,5); % 5 perche' ho 6 punti % grado n = numero di punti meno 1

%-oppure--VANDER MONDE------------------------------------------------------------ 
X=vander(x);
a=X\y;

%-oppure--FATT QR--------------------------------------------------------------- 
% devo scegliere che base utilizzare

% base di parable
X=[x.^2, x, ones(m,1)];   

% base di seni e coseni
w=2*pi/24;  
X=[ones(n,1), sin(w*t), cos(w*t), sin(2*w*t), cos(2*w*t),...
    sin(3*w*t),cos(3*w*t),sin(4*w*t),cos(4*w*t)];

% utilizzo la fatt QR
[Qtilde,Rtilde]=qr(X,"econ");
a=sost_indietro(Rtilde, Qtilde'*y) 

%--------------------------------------------------------------------------
% valuto il polinomio trovato 
x1=linspace(x(1),x(end),100);   % definisco un vettore di punti piu' fitti
y1=polyval(a,x1);   

% nel caso di seni e coseni
g2=a(1)+a(2)*sin(w*t1)+a(3)*cos(w*t1)+...
    a(4)*sin(2*w*t1)+a(5)*cos(2*w*t1)+...
    a(6)*sin(3*w*t1)+a(7)*cos(3*w*t1)+...
    a(8)*sin(4*w*t1)+a(9)*cos(4*w*t1);
%% interpolatore globale di Lagrange (utilizzando la formula baricentrica)
y1=barycentric(x,y,x1);

%% interpolatore composito lineare di Lagrange
y1c=interp1(x,y,x1);

%% spline cubiche
s3=spline(x,y,x1);

%% voglio stimare un singolo punto (xp,yp)
yp=polyval(a,xp)
yp=barycentric(x,y,xp)

