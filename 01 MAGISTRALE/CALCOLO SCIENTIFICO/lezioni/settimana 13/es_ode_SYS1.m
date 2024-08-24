
clc
clear

% eqdiff 4

odefun=@(t,y)[-3*y(1)*y(2)+y(1);
    -y(2)+y(1)*y(2)];

% tspan
tspan=[0,50];
% condizione iniziale

y0=[1;1]
H=[0.01 0.0001];
k=0;
metodo=menu('scegli il metodo','eulero esplicito','euleroimplicito')

for h=H
    k=k+1;
    Nh=fix((tspan(2)-tspan(1))/h);
    if metodo==1
    %chiamo eulero esplicito
        [tn,un]=eulero_esp_sys(odefun,tspan,y0,Nh);
    elseif metodo ==2
        [tn,un]=eulero_imp_sys(odefun,tspan,y0,Nh);
    % rappresento la soluzione
    end
    figure(k);clf
    subplot(2,2,1)
    %plottoy_1
    plot(tn,un(:,1))
    xlabel('t')
    grid on
    ylabel('y_1(t)')
    
    
    subplot(2,2,2)
    plot(tn,un(:,2))
    xlabel('t')
    grid on
    ylabel('y_2(t)')
    
    
    % piano delle fasi
    subplot(2,2,3)
    plot(un(:,1),un(:,2))
    grid on
    xlabel('y_1(t)')
    ylabel('y_2(t)')
    hold on
    plot(y0(1),y0(2),'or','MarkerFaceColor','r')
    title(['h=',num2str(h)]);
end