
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
