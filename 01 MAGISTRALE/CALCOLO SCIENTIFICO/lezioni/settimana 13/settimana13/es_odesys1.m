% es_odesys1

metodo=menu('scegli il metodo','Eulero esplicito',...
    'Eulero implicito',...
    'Crank Nicolson');
% funzione vettoriale del sistema
odefun=@(t,y)[-3*y(1)*y(2)+y(1);
              -y(2)+y(1)*y(2)];
% tspan
tspan=[0,50];
% condizione iniziale
y0=[1;1];


H=[0.01, 0.001];
k=0;
for h=H
    k=k+1;
    Nh=fix((tspan(2)-tspan(1))/h);
    if metodo==1
        % chiamo eulero esplicito
        [tn,un]=eulero_esp_sys(odefun,tspan,y0,Nh);
    elseif metodo ==2
        % chiamo eulero implicito
        [tn,un]=eulero_imp_sys(odefun,tspan,y0,Nh);
    elseif metodo ==3
        % chiamo Crank Nicolson
        [tn,un]=cranknicolson_sys(odefun,tspan,y0,Nh);
    end
    % rappresento la soluzione
    figure(k);clf

    subplot(2,2,1)
    % plotto y_1
    plot(tn,un(:,1))
    grid on
    xlabel('t')
    ylabel('y_1(t)')

    subplot(2,2,2)
    % plotto y_2
    plot(tn,un(:,2))
    grid on
    xlabel('t')
    ylabel('y_2(t)')

    subplot(2,2,3)
    % piano delle fasi
    plot(un(:,1),un(:,2))
    grid on
    xlabel('y_1')
    ylabel('y_2')
    hold on
    plot(y0(1),y0(2),'or','Markerfacecolor','r') % condizione iniziale
    title(['h=',num2str(h)])
end