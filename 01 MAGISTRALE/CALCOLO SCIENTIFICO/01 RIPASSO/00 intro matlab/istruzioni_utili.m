%% calcolo simbolico
syms x  % calcolo simbolico 
f=x*sin (2*x)
g=sin(x)
h=exp(x)

diff(g,1) % derivata prima
diff(g,2) % derivata seconda

int(g,x,0,1) % integrale definito su [a,b]

taylor(h,x,'Order',10) % sviluppo di taylor
f_anon =matlabFunction(f)
%simplify(f)% semplifica
funtool     %tool grafico utile per le operazioni con funzioni
%% matrici
A=[3,4,5;   %matrice generica 3x3
    1,2,3;
    8,9,0]
B=eye(3)    %matrice identità 3x3
C=[1,2,3]   %vettore
D=diag(C)   %matrice diagonale
E=diag(C,1) %matrice sovradiagonale
F=[]        %inizializzo matrice vuota
tril(A)     %estraggo triangolare superiore
triu(A)     %estraggo triangolare inferiore
det(A)      %determinante di A
A'          %simmetrica di A (A^T) o hermitiana di A (A^H)
ones(2,2)   %matrice di 1 2x2
zeros(2,2)  %matrice di 0 2x2
nnz(A)      % restituisce il n° di non zeri di A
%% vettori
ones(5,1)'
v=[1,2,3]
w=[2,2,2]
norm(v)     % norma euclidea
dot(v,w)    %prodotto scalare
cross(v,w)  %prodotto vettoriale

%quiver
%quiver 3
a=0
b=10
n=100
linspace(a,b,n)   %vettore di n punti equispaziati da "a" a "b"
%% polinomi e zeri
x=linspace(-10,10,1000)
f=@(x) (x.^2-4)
y=f(x);
fzero(f,0) % cerco zero vicino a un punto
plot(x,y);grid on;
fzero(f,[0,10]) % cerco uno zero in un intervallo, NB deve cambiare segno
p=[1 0 -4]      % dal grado più alto a quello più basso

polyval(p,x); % polinomio con coefficienti p valutato nei punti x
roots(p)     % calcolo approssimato degli zeri del polinomio p
polyint(p)  %coefficienti della primitiva del polinomio p
polyder(p)  % coefficienti della derivata del polinomio p
%% grafici e funzioni particolari
set(0,'DefaultFigureWindowStyle','docked')
loglog(x,y)
semilogy(x,y)
semilogx(x,y)
cputime
etime
clock
rand(n,m)
ans
quit %chiude matlab
exit %chiude matlab
%nargin(f)  %conta parametri in input
%nargout(f) % conta parametri in output
fix(3.5) %parte intera
sign(-2) %segno
%% funzioni in 2D
% punti scelti da matlab
f=@(x )(2*x- sqrt (2)).^2.* sin (2*x)
figure (1)
fplot (f ,[ -2*pi ,2* pi ]);
legend ('f(x )=(2x -\ sqrt {2})^2\ sin (2x)')
xlabel ('x') % aggiungo label all’asse x
ylabel ('y') % aggiungo

% punti scelti da me
x= linspace ( -2*pi ,2*pi ,1000);
f=@(x) sin(x .^2);
y=f(x);
figure (2) 
plot (x,y)

% inserire una seconda funzione
hold on
g=@(x)( sin(x )).^2;
yg=g(x);
plot (x,y,'b-',x,yg ,'r--');

% inserire la legenda
l= legend ('f(x )=(2x- sqrt (2))^2 sin (2x)','g(x)=e^x cos(x)');
set (l,'Location ','Northwest ')

%% funzioni in 3D
figure (4)

[x,y]= meshgrid ( -2:.1:2 , -2:.1:2);
f=@(x,y)x.* exp(-x.^2 -y .^2);
z=f(x,y); 
%surf (x,y,z); colorbar

%colonne sinistra destra
% ordinate da basso verso altro mentre matrici sono ribaltate


%mesh(x,y,z) %Superfice
%meshc(x,y,z) %Superfice e countour-lines
%surfc(x,y,z) %Superfice e countour-lines
%pcolor(x,y,z) %Superfice colorata piatta
%surf(x,y,z,gradient(z)) %Superfice colorata secondo la grandezza di @z=@x
%contour(x,y,z) %Contour-lines (linee di livello)
%plot3(x,y,z) %Linee lungo la direzione y, serve anche per disegnare linee in 3D
