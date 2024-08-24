% definisco i function handle
f=@(x)(2*x-sqrt(2)).^2.*sin(2*x);
g=@(x)exp(x).*cos(x);
% definisco il vettore delle ascisse
x=linspace(-1,2,100);
% valuto le due funzioni
yf=f(x);
yg=g(x);
% disegno
figure(1); clf
plot(x,yf,x,yg)
xlabel('x')
ylabel('y')
l=legend('f(x)','g(x)');
set(l,'Location','Northwest')
title('output del problema 2')
grid on
% modifico il range di rappresentazione
axis([-1,2,-3,2]) % axis([xmin,xmax,ymin,ymax])