set(0,'DefaultFigureWindowStyle','docked')
% disegno in 3d
% definisco il function handle
f=@(x,y)x.*exp(-(x.^2+y.^2));
% definisco la griglia
[x,y]=meshgrid(-2:.1:2,-2:.1:2);
figure(1); clf
% valuto la funzione
z=f(x,y);
% disegno la funzione
contour(x,y,z,[-0.2,0.2] ); 
colorbar
xlabel('x')
ylabel('y')
zlabel('z')
grid on

figure (2)
subplot (2 ,2 ,1); mesh (x,y,z);
title ('mesh ')
subplot (2 ,2 ,2); surfc (x,y,z);
title ('surfc ')
subplot (2 ,2 ,3); plot3 (x,y,z);
title ('plot3 ')
subplot (2 ,2 ,4); surf (x,y,z, gradient (z ));
title ('surf , gradient ')