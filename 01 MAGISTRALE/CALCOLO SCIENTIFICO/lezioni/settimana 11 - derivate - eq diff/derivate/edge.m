set(0,'DefaultFigureWindowStyle','docked')
close all
clear
clc
A=imread("CALCOLO SCIENTIFICO\settimana 11 - derivate - eq diff\derivate\mozilla-logo-617.png");
figure(1);clf
image(A);
axis equal

%converto in doppia precisione le pagine
R=double(A(:,:,1));%prima pagina
G=double(A(:,:,2));%seconda pagina
B=double(A(:,:,3));%terza pagina
[n,m]=size(R);

% visualizzo rosso
figure(2);
surf(R);
p=surf((R(n:-1:1,:)));
set(p,'Edgecolor','none');
color=zeros(64,3);
color(:,1)=linspace(0,1,64);
colormap(color);
colorbar %barra colori
view([0,90])

% verde
figure(3);
surf(G);
p=surf((G(n:-1:1,:)));
set(p,'Edgecolor','none');
color=zeros(64,3);
color(:,2)=linspace(0,1,64);
colormap(color);
colorbar %barra colori
view([0,90])

%blue
figure(4);
surf(B);
p=surf((B(n:-1:1,:)));
set(p,'Edgecolor','none');
color=zeros(64,3);
color(:,3)=linspace(0,1,64);
colormap(color);
colorbar; %barra colori
view([0,90])

%immagine completa
figure(5);
Z=(R+G+B)/3;
p=surf(Z(n:-1:1,:));
set(p,'Edgecolor','none');
colorbar;
view([0,90])
%% calcolo le derivate parziali
gx= zeros(n,m);
gy= zeros(n,m);
for i=2:n-1
    for j=2:m-1
        gx(i,j)=(Z(i,j+1)-Z(i,j-1))/2;  %df/dx
        gy(i,j)=-(Z(i+1,j)-Z(i-1,j))/2; %df/dy
    end
end

%norma gradiente punto per punto
norma_grad=sqrt(gx.^2+gy.^2);

%calcolo valore medio della norma del gradiente
media_grad=(sum(norma_grad))/(n*m);

%seleziono i pixel in cui norma_grad > 1.5*media_grad
edge_grad=255*uint8(ones(n,m));
for i=1:n
    for j=1:m
        if (norma_grad(i,j) > 1.5*media_grad)
            edge_grad(i,j)=0;
        end
    end
end

%visualizzo la nuova immagine
figure(6);clf
image(edge_grad);
colormap(gray(256));

colorbar;
view([0,90])
axis equal

figure(7);clf
p=surf(norma_grad(n:-1:1,:));
colormap(gray(256));
set(p,'Edgecolor','none');
view([0,90])
axis equal
colorbar;
% figure(7);clf
% p=surf(Z(n:-1:1,:));
% set(p,'Edgecolor','none');
% colorbar;
% view([0,90])
% axis equal