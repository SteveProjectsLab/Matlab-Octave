% es_odesys2
clear
close all
clc

set(0,'DefaultFigureWindowStyle','docked')
% dati
odefun=@(t,y)[y(2);
              -9*y(1)-5*y(2)+exp(-2*t)];
tspan=[0,5];
y0=[0;sqrt(11)/2];

% discretizzazione
H=[0.1,0.01];
%% trasfomazione a un sistema di equazioni del primo ordine con Matlab
% syms y(t)
% ode_s=diff(y,2)+5*diff(y,1)+9*y==exp(-2*t)
% V_s=odeToVectorField(ode)
% % V=
% %                        Y[2]
% % exp(-2*t) - 9*Y[1] - 5*Y[2]
% V=matlabFunction(V_s)
% % V =   
% % @(Y,t)[Y(2);exp(t.*-2.0)-Y(1).*9.0-Y(2).*5.0]

%%
i=1;lambda=-2
for h=H
    Nh=fix((tspan(2)-tspan(1))/h);
    [tn,un]=eulero_esp_sys(odefun,tspan,y0,Nh);
    figure(i)
    subplot(2,2,1)
    plot(tn,un(:,1)) % y(t)=y_1(t)
    grid on
    xlabel('t')
    ylabel('y_1(t)')
    title(['h=',num2str(h)])

    subplot(2,2,2)
    plot(tn,un(:,2)) % y'(t)=y_2(t)
    grid on
    xlabel('t')
    ylabel('y_2(t)')

    subplot(2,2,3)
    plot(un(:,1),un(:,2))
    xlabel('y_1')
    ylabel('y_2')
    grid on
    hold on 
    plot(y0(1),y0(2),'ro','MarkerFaceColor','r')
    plot_stability(1,h,lambda,i+1)
    i=i+2;
end

