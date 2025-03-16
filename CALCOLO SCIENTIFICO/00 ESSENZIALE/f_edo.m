
%% dati del problema ( primo ordine )

odefun=@(t,y)t-y; 
tspan=[-1,3];    
y0=1;

%% dati del problema ( secondo ordine )

A =[-100 1000;
    -10 -100];
g=[0;5];

odefun=@(t,y)A*y+g; % è un sistema lineare

tspan=[0,.1];
y0=[0;0]

%% studiare l'assoluta stabilità (
% guarda se z sta dentro o meno la regione di assoluta stabilità.
% per problemi del 1° ordine usa lambda
% per problemi del 2° ordine calcola gli autovalori se il sistema è lineare
lambda=eig(A)
% per eulero esplicito, trovare h0 per cui sia ass stabile
h0=-2*real(lambda)./abs(lambda).^2

%% risolvere l'edo, calcolare l'errore e rappresentarla
tol=1e-8; kmax=20;
H=[0.5, 0.25, 0.05, 0.025]; % 4 valori del passo di discretizzazione
for h=H
    Nh=fix((tspan(2)-tspan(1))/h); % n. di passi
    
    % risolvo l'edo
    [tn,un]=eulero_esp(odefun,tspan,y0,Nh);
    %[tn,un]=eulero_imp(odefun,tspan,y0,Nh,tol,kmax);
    %[tn,un]=cranknicolson(odefun,tspan,y0,Nh,tol,kmax);
    %[tn,un]=heun(odefun,tspan,y0,Nh);
    %[tn,un]=rk4(odefun,tspan,y0,Nh);
    %[tn,un]=ab3am4(odefun,tspan,y0,Nh);
    
    % calcolo dell'errore
    err=max(abs(yex(tn)-un));
    Err=[Err,err];

    % rappresento la soluzione
    plot(tn,un,'o--','Displayname',['h=',num2str(h)])
end

%% rappresentare l'errore in scala logaritmica
figure(2); 

loglog(H,Err,'Linewidth',2,'Displayname','Err. EI')
hold on
loglog(H,H,'Linewidth',2,'Displayname','H')
hold on
loglog(H,H.^2,'Linewidth',2,'Displayname','H^2')
grid on, legend('-dynamicLegend')
xlabel('h')
ylabel('errori')

%% (extra) stampa regione ass stabilità
grana=0.01
[x,y] = meshgrid(-5:grana:1,-3:grana:3);
z=x+i*y;
R = double(abs(1+z)<1);     %EE
%R = double(abs(1-z)>1);    %EI
%R = double(abs(2+z)./abs(2-z)<1);  % CN
%R =abs(1+z/2.*(2+z))<1;    % Heun
%R =abs(1+z.*(1+ z.*(1/2+z.*(1/6+z/24))))<1;    %rk4
    
contourf(x,y,R,1);colormap([1 1 1;0 1 0]);

% per stampare z del problema in questione
z1=lambda*(real(h)+1i*imag(h));
xp=real(z1); % x nel piano complesso
yp=imag(z1); 