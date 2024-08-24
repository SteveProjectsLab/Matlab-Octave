% disegno di una superficie in forma parametrica

[r,theta]=meshgrid(0:.1:2,0:.1:6*pi);
x=r.*cos(theta);
y=r.*sin(theta);
z=theta;

figure(1); clf
s=surf(x,y,z);
s.EdgeColor='none';
colorbar

grid on
xlabel('x')
ylabel('y')
colormap('default')