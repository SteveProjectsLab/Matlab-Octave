% es_circuito
close all
% dati del circuito
L=0.1; R1=10;
R2=10;
C=1e-3;
e=5; 

A=[-1/(C*R2) 1/C;
   -1/L -R1/L];
g=[0;e];
odefun=@(t,y)A*y+g;
%odefun=@(t,y)[1/C*(y(2)-y(1)/R2);
%              1/L*(-y(2)*R1-y(1)+e)];



y0=[0;0];
tspan=[0,.1];

%discretizzo
H=[0.001, 0.005, 0.01, 0.02];

for h=H
    Nh=fix((tspan(2)-tspan(1))/h);
    %[tn,un]=eulero_esp_sys(odefun,tspan,y0,Nh);
    [tn,un]=eulero_imp_sys(odefun,tspan,y0,Nh);
    figure
    subplot(2,2,1)
    plot(tn,un(:,1)) % y(t)=y_1(t)
    grid on
    xlabel('t')
    ylabel('v(t)')
    title(['h=',num2str(h)])

    subplot(2,2,2)
    plot(tn,un(:,2)) % y'(t)=y_2(t)
    grid on
    xlabel('t')
    ylabel('i_1(t)')

    subplot(2,2,3)
    plot(un(:,1),un(:,2))
    xlabel('v')
    ylabel('i_1')
    grid on
    hold on 
    plot(y0(1),y0(2),'ro','MarkerFaceColor','r')
end

%%
% calcolo gli autovalori di A
lambda=eig(A)

% stiamo alvorando con EE
% calcolo h0 per entrambi gli autovalori
h0=-2*real(lambda)./abs(lambda).^2
% nel caso di autovalori non complessi coniugati, 
% il vettore h0 puo' assumere valori diversi, alla fine
% bisogna tenere  il minimo di tutte le componenti del vettore h0
% risulta min h0=0.01
tspan=[0,1];

%discretizzo
H=[0.008, 0.011];

for h=H
    Nh=fix((tspan(2)-tspan(1))/h);
    [tn,un]=eulero_esp_sys(odefun,tspan,y0,Nh);
    figure
    subplot(2,2,1)
    plot(tn,un(:,1)) % y(t)=y_1(t)
    grid on
    xlabel('t')
    ylabel('v(t)')
    title(['h=',num2str(h)])

    subplot(2,2,2)
    plot(tn,un(:,2)) % y'(t)=y_2(t)
    grid on
    xlabel('t')
    ylabel('i_1(t)')

    subplot(2,2,3)
    plot(un(:,1),un(:,2))
    xlabel('v')
    ylabel('i_1')
    grid on
    hold on 
    plot(y0(1),y0(2),'ro','MarkerFaceColor','r')
end
%%  RK4
% es_circuito
close all
% dati del circuito
L=0.1; R1=10;
R2=10;
C=1e-3;
e=5; 

A=[-1/(C*R2) 1/C;
   -1/L -R1/L];
g=[0;e];
odefun=@(t,y)A*y+g;

y0=[0;0];
tspan=[0,1];

H=[0.005, 0.015, 0.022];

for h=H
  Nh=fix((tspan(2)-tspan(1))/h);
  [tn,un]=rk4(odefun,tspan,y0,Nh);
  figure;
  subplot(2,2,1)
  plot(tn,un(:,1),'.--')
  grid on
  xlabel('t')
  ylabel('v(t)')
  subplot(2,2,2)
  plot(tn,un(:,2),'.--')
  grid on
  xlabel('t')
  ylabel('i_1(t)')
  subplot(2,2,3)
  plot(un(:,1),un(:,2),'.--')
  grid on
  xlabel('v(t)')
  ylabel('i_1(t)')
  hold on
  plot(y0(1),y0(2),'ro','MarkerFaceColor','r')
  title(['RK4: h=',num2str(h)])
end


