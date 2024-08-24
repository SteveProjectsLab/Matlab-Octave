% es_circuito
clear
close all
clc
set(0,'DefaultFIgureWindowStyle','docked')
%% dati del circuito
L=0.1; R1=10; R2=10; C=1.e-3; e=5; 

A=[-1/(C*R2) 1/C;
   -1/L -R1/L];
g=[0;e];
odefun=@(t,y)A*y+g; % è un sistema lineare
%odefun=@(t,y)[1/C*(y(2)-y(1)/R2);
%              1/L*(-y(2)*R1-y(1)+e)];
y0=[0;0];
tspan=[0,.1];
%% calcolo gli autovalori di A

lambda=eig(A)
% stiamo alvorando con EE
% calcolo h0 per entrambi gli autovalori
h0=-2*real(lambda)./abs(lambda).^2
% nel caso di autovalori non complessi coniugati, 
% il vettore h0 puo' assumere valori diversi, alla fine
% bisogna tenere  il minimo di tutte le componenti del vettore h0
% risulta min h0=0.01
% lambda =
%    1.0e+02 *
%   -1.0000 + 1.0000i
%   -1.0000 - 1.0000i
% 
% h0 =
%     0.0100
%     0.0100
%% risolvo con eulero eplicito
%discretizzo
H=[0.001, 0.005, 0.01, 0.02];
i=1;% indice figura
for j=1:4
    for h=H
        Nh=fix((tspan(2)-tspan(1))/h);
        if j==1
            [tn,un]=eulero_esp_sys(odefun,tspan,y0,Nh);
            titleName='eulero eplicito'
            plot_stability(1,h,lambda(1),i+1)
            plot_stability(1,h,lambda(2),i+2)
        elseif j==2
            if h==0.001
                pause; close all; figure(i);
            end
            [tn,un]=eulero_imp_s(odefun,tspan,y0,Nh);
            titleName='eulero implicito'
            plot_stability(2,h,lambda(1),i+1)
            plot_stability(2,h,lambda(2),i+2)
        elseif j==3
            if h==0.001
                pause; close all; figure(i);
            end
            [tn,un]=rk4(odefun,tspan,y0,Nh);
            titleName='Heun'
            plot_stability(4,h,lambda(1),i+1)
            plot_stability(4,h,lambda(2),i+2)
        elseif j==4
            if h==0.001
                pause; close all; figure(i);
            end
            [tn,un]=rk4(odefun,tspan,y0,Nh);
            titleName='RK4'
            plot_stability(5,h,lambda(1),i+1)
            plot_stability(5,h,lambda(2),i+2)
        end
        figure(i)
        % stampo la prima componente
        subplot(2,2,1)
        plot(tn,un(:,1),'.--') % y(t)=y_1(t)
        grid on
        xlabel('t')
        ylabel('v(t)')
        title(titleName)

        % stampo la seconda componente
        subplot(2,2,2)
        plot(tn,un(:,2),'.--') % y'(t)=y_2(t)
        grid on
        xlabel('t')
        ylabel('i_1(t)')
        title(['h=',num2str(h)])

        % stampo il piano delle fasi
        subplot(2,2,3)
        plot(un(:,1),un(:,2),'.--')
        xlabel('v')
        ylabel('i_1')
        grid on
        hold on 
        plot(y0(1),y0(2),'.--','MarkerFaceColor','r')
        i=i+3;
    end
end


