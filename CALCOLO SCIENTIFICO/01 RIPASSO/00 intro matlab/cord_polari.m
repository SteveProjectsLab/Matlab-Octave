% coordinate polari
% esercizio elica
[r, theta]=meshgrid(0:.1:2,0:.1:6*pi);
x=r.*cos(theta);
y=r.*sin(theta);
z=theta;

figure(1)
s=surf(x,y,z) % così vedo che proprietà posso modificare
s.EdgeColor='none';
grid on; 

xlabel('x')
ylabel('y')
colormap('autumn')%vedi i vari stili

