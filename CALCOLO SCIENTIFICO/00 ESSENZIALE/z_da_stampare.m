
%% disegno 2D
x= linspace (-1,2,1000);

f=@(x)(2*x-sqrt(2)).^2.*sin(2*x);
y=f(x);
plot (x,y)
% fplot(x,I)
%% disegno 3D

[x,y]= meshgrid ( -2:.1:2 , -2:.1:2);
f=@(x,y)x.* exp(-x.^2 -y .^2);
z=f(x,y);

mesh(x,y,z) %Superfice
%surf (x,y,z); 
colorbar

%% gradiente contorni
[X,Y] = meshgrid(-2:0.2:2);
Z = X.*exp(-X.^2 - Y.^2);
[DX,DY] = gradient(Z,0.2);

figure(1);surf(X,Y,Z,gradient(Z));colorbar; %Superfice colorata secondo la grandezza di @z=@x

figure(2);quiver(X,Y,DX,DY)
hold on
contour(X,Y,Z)

%% movie

f=@(x,y,t)sin(sqrt(x.^2+y.^2)-2*t);
[x,y]=meshgrid(-2*pi:.2:2*pi);% stessa discretizzazione per x e y
numero_campioni=50
durata=2*pi;
t=linspace(0,durata,numero_campioni);

Mv=struct('cdata',{},'colormap',{});
figure(1);clf
for n=1:numero_campioni
    z=f(x,y,t(n));
    s=surf(x,y,z);
    s.EdgeColor= "none";
    % axis=([-2*pi,2*pi,-2*pi,2*pi])
    Mv(n)=getframe;

    pause(0.01)
end
movie(Mv,10);

%% SISTEMI NON LINEARI
syms x1 x2
f_s=[x1^2-x2^2-1;
       x1^2+x2^2-2*x1-3];
Jf_s=jacobian(f_s,[x1,x2])


x0=[1;1]; % punto iniziale

tol=1e-6;
kmax=50;

[zero1,res1,k1,ERR1]=newtonsys(f,Jf,x0,tol,kmax)

% oppure
B0=eye(2)

fprintf('utilizzo il metodo di Broyden\n')
x0=[1;1]; 
[ZERO,RES,NITER,ERR]=broyden(f,B0,x0,tol,kmax) 

% oppure con Matlab
zero_s=solve(f_s,[x1 x2])
zero1=double([zero_s.x1(1) zero_s.x2(1)])
zero2=double([zero_s.x1(2) zero_s.x2(2)])
zero2=double([zero_s.x1(3) zero_s.x2(3)])

%% SISTEMI LINEARI - METODI ITERATIVI

A=[6 1 -2 2 1; 1 3 1 -2 0; -2 1 4 -1 -1; 2 -2 -1 4 2; 1 0 -1 2 3];
b=[15;2;3;21;21];

x0=rand(5,1);

tol=1e-12;
kmax=500;

[x,res,k,resvec]=gradiente(A,b,x0,tol,kmax)%% gradiente

[x1,res1,k1,resvec1]=gradiente_coniugato(A,b,x0,tol,kmax)%% gradiente coniugato

[x2,res2,k2,resvec2]=bcgstab(A,b,x0,tol,kmax)%% bcgstab

%% rappresento gli errori
figure(1); clf

semilogy((0:k)', resvec,'DisplayName','G','Color','r','LineWidth',2)
hold on
semilogy((0:k1)', resvec1,'DisplayName','GC','Color','k','LineWidth',2)
hold on
semilogy((0:k2)', resvec2,'DisplayName','BICGStab','Color','b','LineWidth',2)
grid on
legend('-dynamicLegend')
%% SISTEMI LINEARI - METODI DIRETTI
% sistema con A triangolare superiore
A=[ 1 1 3 0;
    0 1 2 -1;
    0 0 4 1;
    0 0 0 3]
b=[2 2 6 6]';

x=sost_indietro(A,b)

% sistema con A triangolare inferiore
A=[ 1 0 0 0;
    5 1 0 0;
    2 2 4 0;
    4 1 0 3]
b=[2 2 6 6]';

x=sost_avanti(A,b)

% sistema A generico MEG + MEG pivotazione

A=[10 4 3 -2; 2 20 20 -1; 3 -6 4 3; -3 0 3 1];
b=[5;24;13;-2];

x=meg(A,b)  % senza pivotazione

x=meg_pivot(A,b)    % con pivotazione

% sistema A generico LU + LU pivotazione
A=[10 4 3 -2; 2 20 20 -1; 3 -6 4 3; -3 0 3 1];
b=[5;24;13;-2];

[L,U]=lufact(A,0);  % fatt LU senza pivoting
%[L,U,P]=lufact(A,1);  % fatt LU con pivoting

y=sost_avanti(L,b); % risolvo Ly=b
%y=sost_avanti(L,P*b); nel caso uso pivoting

x=sost_indietro(U,y) % risolvo Ux=y

% Lu matlab
[L,U]=lu(A)
y=L\b
x=U\y

[L,U,P]=lu(A)
y=L\(P*b)
x=U\y

[L,U,P,Q]=lu(sparse(A))


% fattorizzazione QR
A=[ 0 1;
    0.06 1; 
    0.14 1; 
    0.25 1; 
    0.31 1;
    0.47 1;
    0.6 1;
    0.7 1]
b=[0 ;0.08 ;0.14 ;0.20 ;0.23 ;0.25; 0.28 ;0.29];

[Q,R]=qr(A)

% pag 181 libro

Qt=Q(:,1:2)
Rt=R(1:2,:)
xstar= Rt\(Qt'*b)
A=Q*R
%% APPROSSIMARE I DATI
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

y1=barycentric(x,y,x1); % interpolatore globale di Lagrange (utilizzando la formula baricentrica)

y1c=interp1(x,y,x1);% interpolatore composito lineare di Lagrange

s3=spline(x,y,x1);% spline cubiche

% voglio stimare un singolo punto (xp,yp)
yp=polyval(a,xp)
yp=barycentric(x,y,xp)
%% APPROSSIMARE UNA FUNZIONE
f=@(x) (x+2)/7.*cos(x)   % funzione da approssimare

% utilizzo nodi equispaziati
x1=linspace(a,b,200);
f1=f(x1); 
y1=polyval(a,x1);
err=max(abs(f1-y1));
% utilizzo nodi di Cheb
xs=-cos(pi*(0:n)/n); xs=xs'; % nodi su [-1,1]
x=(xb-xa)/2*xs+(xa+xb)/2;  % nodi su [xa,xb]
y=f(x);

if n<20 %matrice VM ancora ok
        X=vander(x);
        a=X\y;
        y1=polyval(a,x1);
            
elseif n>=20    % la matrice di VM sarebbe mal condizionata
    y1=barycentric(x,y,x1);
end

semilogy((1:n), ERR, '-*','Linewidth',2)% rappresento l'andamento dell'errore
%% INTEGRALI
f=@(x)2.39e-11./(x.^5.*(exp(1.432./(213*x))-1));
for M=10:10:1000
    %fdq a scelta
    H=[H,(xb-xa)/M]; % valuto e salvo l'ampiezza degli intervallini
    Err=[Err,abs(Iex-Iapp)]; % valuto e salvo l'errore nella lista Err
end
err=abs(Iex-Iapp); 

Hmax=sqrt((err*24)/((b1-a1)*(maxd2f1)))
M_min=ceil((b1-a1)/Hmax)

%fdq gaussiana
[x,w]=xwlg(np,xa,xb);% calcolo i nodi LG
    Ilg=sum(f(x).*w);

f=@(x)1./(x.^3-2*x-5)
I=integral(f,0,2,'AbsTol',1.e-5)
%% EQUAZIONI DIFFERENZIALI ORDINARIE
odefun=@(t,y)t-y; 
odefun=@(t,y)[y(2);
              -9*y(1)-5*y(2)+exp(-2*t)];
odefun=@(t,y)A*y+g; % per sistemi lineari

% per eulero esplicito, trovare h0 per cui sia ass stabile
h0=-2*real(lambda)./abs(lambda).^2

Nh=fix((tspan(2)-tspan(1))/h);

plot(tn,un(:,1)) % y(t)=y_1(t)  % nel caso sia vettoriale


Err=[Err,err];% nel for
err=max(abs(yex(tn)-un));

%% in edo, integrali
loglog(H,Err,'Linewidth',2,'DisplayName','errori')
loglog(H,H,'Linewidth',2,'DisplayName','H^2')
loglog(H,H.^2,'Linewidth',2,'DisplayName','H^2')
loglog(H,H.^4,'Linewidth',2,'DisplayName','H^4')

%% in interpolazione
semilogy((1:n), ERR, '-*','Linewidth',2)

%% comandi matlab
x=A\b
% il comando \ esegue sempre la pivotazione
% comandi utili
spy(A) 

[Q,R]=qr(A)

colperm(A)
% fattorizzazione LU + fatt LU con pivotazione
A=[2,3,4;    1,2,1;    3,0,1]
% det(1)  %1
% det([2,0;0,1]) %2
% det(A) % -14
% ho le sottomatrici principali non singolari, posso applicare fatt lu

% senza pivotazione
[L,U]=lu(A)
y=L\b
x=U\y

Aric=L*U   % commetto degli errori

% con pivotazione
[L,U,P]=lu(A)
y=L\(P*b)
x=U\y

% A non sdp

A=[2,3,4;     1,2,1;    3,0,1]
issymmetric(A)% non è simemtrica
eig(A)% Non ha tutti gli autovalori positivi

% non è quindi sdp
% A sdp, posso applicare choleshy
A=[20 4 5;4 2 3;5 3 5]

issymmetric(A)% si
eig(A)% ha tutti gli autovalori positivi

% quindi A è simmetrica definita positiva
% posso applicare cholesky

R=chol(A)

Aric=R'*R

% trovare gli zeri di una funzione
z=fzero(f) % solo per radici reali

% trasformare anonymous function in symbolic function ( e viceversa)
b=@(t)2500/(1+9*exp(-t/3))

b_s=sym(b)

b1=matlabFunction(b_s)

% derivate

db=matlabFunction(diff(b_s,1))  % derivata prima

ddb=matlabFunction(diff(b_s,2)) % derivata seconda


% integrali
syms x
f=1/(1+(x-2)^2) 

I=int(f)        % integrale indefinito            

Idef=int(f,0,2) % integrale definito su [a,b]

% oppure utilizzare l'integrale numerico
I = integral(fun,xmin,xmax)
I=integral(f,0,2,'AbsTol',1.e-5)
% equazioni differenziali

% edo
syms y(t)
ode = diff(y,t) == t*y
ySol(t)=dsolve(ode) 
%--------------------------------------------------------------------------
% imporre una condizione iniziale

cond = y(0) == 2;  
ySol(t) = dsolve(ode,cond)
%--------------------------------------------------------------------------
% sistema di edo

syms y(t) z(t)
eqns = [diff(y,t) == z, diff(z,t) == -y];
S = dsolve(eqns)
%--------------------------------------------------------------------------
% ridurre il grado dell'edo

syms y(t)
eqn = diff(y,2) + y^2*t == 3*t;
V = odeToVectorField(eqn)
