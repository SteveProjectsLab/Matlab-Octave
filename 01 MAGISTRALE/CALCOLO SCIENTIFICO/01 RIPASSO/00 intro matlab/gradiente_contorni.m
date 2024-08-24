%openExample('matlab/PlotGradientAndContoursExample')
set(0,'DefaultFigureWindowStyle','docked')
clear 
close all
clc

spacing = 0.2;
[X,Y] = meshgrid(-2:spacing:2);
Z = X.*exp(-X.^2 - Y.^2);
[DX,DY] = gradient(Z,spacing);

figure(1)
surf(X,Y,Z,gradient(Z));colorbar; %Superfice colorata secondo la grandezza di @z=@x

figure(2)
quiver(X,Y,DX,DY)
hold on
contour(X,Y,Z)
axis equal
hold off

