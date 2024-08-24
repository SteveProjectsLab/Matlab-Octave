close all
clear
clc

odefun=@(t,y)[y(2);
-9*y(1)-5*y(2)+exp(-2*t)];
tspan=[0,5];
y0=[0,sqrt(11)/2];

% discretizzazione
H=[0.1 0.001]
k=0
for h=H
    k=k+1;
    Nh=fix((tspan(2)-tspan(1))/h)
    [tn,un]=eulero_esp_sys(odefun,tspan,y0,Nh);
    figure(k)
    subplot(2,2,1)
    plot(tn,un(:,1))
    grid on
    xlabel('t')
    ylabel('y_1(t)')
    
    subplot(2,2,2)
    plot(tn,un(:,2))
    grid on
    xlabel('t')
    ylabel('y_2(t)')


    subplot(2,2,3)
    plot(un(:,1),un(:,2))
    grid on
    xlabel('y_1(t)')
    ylabel('y_2(t)')
    hold on
    plot(y0(1),y0(2),'or','MarkerFaceColor','r')
    title(['h=',num2str(h)]);
end