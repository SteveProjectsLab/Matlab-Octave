% tema d'esame del 13/01/2015
% es3
% y_1 =y
% y_2=y'=y_1'
% y_3=y''= y_2'

% y_1'=y_2
% y_2'=y_3
% y_3'=1/2(-2*y_3-3*y_2-3*y_1+sin(t))

odefun=@(t,y)[y(2);
             y(3);
             0.5*(-2*y(3)-3*y(2)-3*y(1)+sin(t))];
tspan=[0,40];
y0=[1;-2;4];
% discretizzazione
H=0.01;
figure(1); clf
for h=H
    Nh=fix((tspan(2)-tspan(1))/h);
    [tn,un]=eulero_esp_sys(odefun,tspan,y0,Nh);
    plot(tn,un(:,1),'.--','Displayname',['EE h=',num2str(h)])
    legend('-dynamiclegend')
    hold on
    grid on
    xlabel('t')
    ylabel('x(t)')
    
    [tn4,un4]=rk4(odefun,tspan,y0,Nh);
    plot(tn4,un4(:,1),'.--','Displayname',['RK4 h=',num2str(h)])
    
    pause(1)
end

%% ass. stabilita'
A=[0 1 0;
   0 0 1;
   -1.5 -1.5 -1];
odefun=@(t,y)A*y;
lambda=eig(A)

% per EE non ass. stab.
% per RK4 richiedo h< 2.7 per il lambda reale
% h< 2.2 per lambda imm. 
% devo tenere l'h piu' restrittivo.
% discretizzazione
H=[0.01, 1.8 1.9 2. 2.1 2.2 2.3 2.4];
figure(1); clf
for h=H
Nh=fix((tspan(2)-tspan(1))/h);
[tn4,un4]=rk4(odefun,tspan,y0,Nh);
plot(tn4,un4(:,1),'.--','Displayname',['RK4 h=',num2str(h)])
legend('-dynamiclegend')
hold on
grid on
xlabel('t')
ylabel('x(t)')


pause 
end

% lanciando il codice, vediamo che con h<=2.2 le oscillazioni rimangono
% limitate e sono principalmente dovute al comportamento oscillatorio del
% sistema.
% per h=2.3 le oscillazioni esplondono in ampiezza
% per garantire ass. satbilita' prendero' h<=2.2

%% esempio di chiamata di una function matlab
odefun=@(t,y)[y(2);
             y(3);
             0.5*(-2*y(3)-3*y(2)-3*y(1)+sin(t))];
tspan=[0,40];
y0=[1;-2;4];
% discretizzazione
 
figure(1); clf
 
%%
% ode45 usa RK4+Rk5 ed e' adattivo
% il passo h e' dinamico e calcolato 
% ad ogni passo in modo da garantire che
% l'errore rispetto alla sol esatta sia circa 1e-3
[tn,un]=ode45(odefun,tspan,y0);

% se si vuole una tolleranza diversa
%options=odeset('RelTol',1e-6);
%[tn,un]=ode45(odefun,tspan,y0,options);

plot(tn,un(:,1),'.--','Displayname','ode45')
legend('-dynamiclegend')
hold on
grid on
xlabel('t')
ylabel('x(t)')
% richiamo RK4 con passo costante
h=0.01;
Nh=fix((tspan(2)-tspan(1))/h);
[tn4,un4]=rk4(odefun,tspan,y0,Nh);
plot(tn4,un4(:,1),'.--','Displayname',['RK4 h=',num2str(h)])
 
% disegno i tn di ode45
plot(tn,zeros(size(tn)),'+r')
