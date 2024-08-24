% es_circuito
close all
% dati del circuito
L=0.1; R1=10;
R2=10;
C=1e-3;
e=5; 
odefun=@(t,y)[1/C*(y(2)-y(1)/R2);
              1/L*(-y(2)*R1-y(1)+e)];
y0=[0;0];
tspan=[0,.1];

%discretizzo
H=[0.001, 0.005, 0.01, 0.02];

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