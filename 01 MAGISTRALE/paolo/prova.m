f=@(x,y) y.*sin(x) - x.*cos (y);
fsurf(f, [-2*pi 2*pi])
xlabel('x')
yLabel('y')