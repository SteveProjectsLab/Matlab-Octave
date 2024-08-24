set(0,'DefaultFigureWindowStyle','docked')
clear
close all
clc
A = [2 3 4; 1 -2 1]
B = [3 1 4; 2 -1 0; -2 7 1]

C=A*B


c=2\3 % fa 

f=@(x)(2*x- sqrt (2)).^2.* sin (2*x)

% apro una finestra grafica (che ha numero 1)

figure (1)
% fplot(f,[a,b]), [a,b] intervallo di definizione

fplot (f ,[ -2*pi ,2* pi ]);
legend ('f(x )=(2x -\ sqrt {2})^2\ sin (2x)')
xlabel ('x') % aggiungo label all’asse x
ylabel ('y') % aggiungo


x= linspace ( -2*pi ,2*pi ,1000);% con 100 faceva schifo
% x=linspace(a,b,n) crea un vettore riga di n elem,
% contenenti le ascisse di n punti equispaziati
% sull’intervallo chiuso [a,b]

f=@(x) sin(x .^2);
y=f(x);
figure (2) 
plot (x,y)

% genera spezzata che congiunge i punti
% devo arricchire il vettore x es con 1000 punti

% se voglio aggiungere un altro grafico devo scrivere "hold on"

g=@(x)( sin(x )).^2;
yg=g(x);
plot (x,y,'b-',x,yg ,'r--');




%%  %esercizio 2D

x= linspace (-1,2,1000);

f=@(x)(2*x-sqrt(2)).^2.*sin(2*x);
g=@(x)exp(x).*cos(x);

yf=f(x);
yg=g(x);

figure(3) 

plot (x,yf)
hold on
plot (x,yg)
grid on

%% esercizio 3D

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


