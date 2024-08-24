set(0,'DefaultFigureWindowStyle','docked')
close
clear all
clc
% es edge
A=imread('mozilla-logo-617','png'); % carico l'immagine
% A=imread('mozilla-logo-617.png');

% visualizzo l'immmagine
figure(1); clf
image(A)
axis equal

%% coverto in doppia precisione le pagine dell'array
R=double(A(:,:,1));
G=double(A(:,:,2));
B=double(A(:,:,3));

% visualizzo i rossi
[n,m]=size(R);
figure(2); clf
p=surf(R(n:-1:1,:));
set(p,'Edgecolor','none')
% definisco una mappa di colori di solo rosso
color=zeros(64,3);
color(:,1)=linspace(0,1,64);
colormap(color)
colorbar % barra dei colori

% visualizzo i verdi
 
figure(3); clf
p=surf(G(n:-1:1,:));
set(p,'Edgecolor','none')
% definisco una mappa di colori di solo verde
color=zeros(64,3);
color(:,2)=linspace(0,1,64);
colormap(color)
colorbar % barra dei colori

% visualizzo i blue
 
figure(4); clf
p=surf(B(n:-1:1,:));
set(p,'Edgecolor','none')
% definisco una mappa di colori di solo blue
color=zeros(64,3);
color(:,3)=linspace(0,1,64);
colormap(color)
colorbar % barra dei colori

%% costruisco una funzione intensita di colore = media dei 3 colori

Z=(R+G+B)/3;

figure(5); clf
p=surf(Z(n:-1:1,:));
set(p,'Edgecolor','none')
colorbar

%% calcolo le derivate parziali
gx=zeros(n,m);
gy=zeros(n,m);
for i=2:n-1
    for j=2:m-1
        gx(i,j)=(Z(i,j+1)-Z(i,j-1))/2;  % df/dx
        gy(i,j)=-(Z(i+1,j)-Z(i-1,j))/2; % df/dy
    end
end

% calcolo la norma del gardiente punto per punto
norma_grad=sqrt(gx.^2+gy.^2);

% calcolo il valore medio della norma del gradiente
media_grad=sum(sum(norma_grad))/(n*m);

% selezioni ni pixel in cui norma_grad > 1.5*media_grad

edge_grad=255*uint8(ones(n,m)); % tutti pixel bianchi
for i=1:n
    for j=1:m
        if norma_grad(i,j)> 1.5*media_grad
            edge_grad(i,j)=0;
        end
    end
end
% visualizzo la nuova immagine
figure(6); clf
image(edge_grad); 
colormap(gray(256))
title('Edge grad')

% visualizzo la funzione norma_grad

figure(7); clf
p=surf(norma_grad(n:-1:1,:));
set(p,'Edgecolor','none')
view([0,90])

%% calcolo il laplaciano
lap=zeros(n,m);
for i=2:n-1
    for j=2:m-1
        lap(i,j)=Z(i,j+1)-4*Z(i,j)+Z(i,j-1)+Z(i+1,j)+Z(i-1,j);
    end
end

% calcolo il valore assoluto del laplaciano
abslap=abs(lap);

% calcolo il valore medio del valore assoluto del laplaciano
media_lap=sum(sum(abslap))/(n*m);

% seleziono ni pixel in cui abslap > 1.5*media_lap

edge_lap=255*uint8(ones(n,m)); % tutti pixel bianchi
for i=1:n
    for j=1:m
        if abslap(i,j)> 1.5*media_lap
            edge_lap(i,j)=0;
        end
    end
end
% visualizzo la nuova immagine
figure(8); clf
image(edge_lap); 
colormap(gray(256))
title('Edge laplaciano')

% visualizzo la funzione norma_grad

figure(9); clf
p=surf(abslap(n:-1:1,:));
set(p,'Edgecolor','none')
view([0,90])