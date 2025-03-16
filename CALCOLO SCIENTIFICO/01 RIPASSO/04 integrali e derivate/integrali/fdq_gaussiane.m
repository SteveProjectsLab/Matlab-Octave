clear
close all
clc

% quadratura gaussiana

f=@(x)cos(x).*exp(-x.^2);
xa=-3; xb=2;
[x,w]=xwlg(10,xa,xb);   % calcolo nodi e pesi di quadratura Legendre-Gauss
Ilg= sum(f(x).*w)       % calcolo l'integrale con la sommatoria

%% LG vs Trapezi

% dati
f=@(x)cos(2*pi*x)+exp(sin(x)).*cos(x);
xa=-3;
xb=2;
Iex=exp(sin(2))-exp(sin(-3));
Err=[];
Errt=[];
for np=3:21
    
    [x,w]=xwlg(np,xa,xb);% calcolo i nodi LG
    Ilg=sum(f(x).*w);
    Err=[Err,abs(Iex-Ilg)];% calcolo l'integrale con trapezi su nodi equi
    
    x=linspace(xa,xb,np);
    It=trapz(x,f(x));
    Errt=[Errt,abs(Iex-It)];
end

figure(1); clf
semilogy(3:21,Err,'Linewidth',2,'Displayname','err LG')
legend('-dynamiclegend')
hold on
semilogy(3:21,Errt,'Linewidth',2,'Displayname','err trapz')
grid on
xlabel('np')
ylabel('errori')

%% integrale matlab

f=@(x)1./(x.^3-2*x-5)
I=integral(f,0,2,'AbsTol',1.e-5)

