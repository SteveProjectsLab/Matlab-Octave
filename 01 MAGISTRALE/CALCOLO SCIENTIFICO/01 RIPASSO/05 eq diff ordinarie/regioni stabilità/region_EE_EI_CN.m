clear
close all
clc

set(0,'DefaultFigureWindowStyle','docked')

%% REGIONE DI STABILITà DI EE
figure(1)
[x,y] = meshgrid(-4:0.01:1,-2:0.01:2);
lambda=1
z=lambda*(x+i*y);
R = double(abs(1+z)<1);
contourf(x,y,R,1);
axis ij; grid off; hold on
h = line([-4,1],[0,0]); set(h,'Color','k');
h = line([0,0],[-2,2]); set(h,'Color','k');
title('Eulero Esplicito')

%% REGIONE DI STABILITà DI EI
figure(2)
[x,y] = meshgrid(-1:0.01:5,-2:0.01:2);
lambda=1
z=lambda*(x+i*y);
R = double(abs(1-z)<=1);
contourf(x,y,R,1);
axis ij; grid off; hold on
h = line([-1,5],[0,0]); set(h,'Color','k');
h = line([0,0],[-2,2]); set(h,'Color','k');
title('Eulero Implicito')
%% REGIONE DI STABILITà DI CN
figure(3)
[x,y] = meshgrid(-4:0.01:1,-2:0.01:2);
lambda=1
z=lambda*(x+i*y);
R = double(abs(2+z)./abs(2-z)<1);
contourf(x,y,R,1);
axis ij; grid off; hold on
h = line([-4,1],[0,0]); set(h,'Color','k');
h = line([0,0],[-2,2]); set(h,'Color','k');

title('CrankNicolson')