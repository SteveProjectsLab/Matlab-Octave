% es GL 2
% dati
f=@(x)cos(2*pi*x)+exp(sin(x)).*cos(x);
xa=-3;
xb=2;
Iex=exp(sin(2))-exp(sin(-3));
Err=[];
Errt=[];
for np=3:21
    % calcolo i nodi LG
    [x,w]=xwlg(np,xa,xb);
    Ilg=sum(f(x).*w);
    Err=[Err,abs(Iex-Ilg)];
    % calcolo l'integrale con trapezi su nodi equi
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
