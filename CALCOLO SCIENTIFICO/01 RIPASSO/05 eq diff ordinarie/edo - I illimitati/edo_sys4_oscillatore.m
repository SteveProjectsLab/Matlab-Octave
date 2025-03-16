% es_oscillatore
% dati

Fe=@(t)0;
m=0.5;
R=0.2;
K=0.8;
x0=1;
A=[0,1;
  -K/m, -R/m];
g=@(t)[0;Fe(t)/m];
odefun=@(t,y)A*y+g(t);
tspan=[0,30]; % intervallo temporale
y0=[x0,0]; % suppongo che all'istante iniziale il corpo sia fermo,
% velocita' nulla
figure(1);clf
H=[0.001, 0.1,0.4,0.8,1];
for h=H
    Nh=fix((tspan(2)-tspan(1))/h);
    [tn,un]=ab3am4(odefun,tspan,y0,Nh);
    plot(tn,un(:,1),'.--','Displayname',['h=',num2str(h)])
    legend('-dynamiclegend')
    hold on
    grid on
    xlabel('t')
    ylabel('x(t)')
    pause
end

%% con forza esterna non nulla
Fe=@(t)1; % poi provare con sin(t)
m=0.5;
R=0.2;
K=0.8;
x0=1;
A=[0,1;
  -K/m, -R/m];
g=@(t)[0;Fe(t)/m];
odefun=@(t,y)A*y+g(t);
tspan=[0,30]; % intervallo temporale
y0=[x0,0]; % suppongo che all'istante iniziale il corpo sia fermo,
% velocita' nulla
figure(1);clf
H=[0.001, 0.1,0.4,0.8,1];
for h=H
    Nh=fix((tspan(2)-tspan(1))/h);
    [tn,un]=ab3am4(odefun,tspan,y0,Nh);
    plot(tn,un(:,1),'.--','Displayname',['h=',num2str(h)])
    legend('-dynamiclegend')
    hold on
    grid on
    xlabel('t')
    ylabel('x(t)')
    pause
end

%% analisi di ass. stabilita'
lambda=eig(A)
tspan=[0,50]; % intervallo temporale
% dalla regione di ass. stabilita' vedo che h0 e' circa 0.9
figure(1);clf
H=[0.001,0.86 0.88 0.9 0.92 0.94];
for h=H
Nh=fix((tspan(2)-tspan(1))/h);
[tn,un]=ab3am4(odefun,tspan,y0,Nh);
plot(tn,un(:,1),'.--','Displayname',['h=',num2str(h)])
legend('-dynamiclegend')
hold on
grid on
xlabel('t')
ylabel('x(t)')
pause
end
% dai risultati numerici confermo  h0~0.9
