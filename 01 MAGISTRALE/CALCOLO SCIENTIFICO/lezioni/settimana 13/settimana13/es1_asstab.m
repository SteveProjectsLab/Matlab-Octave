% es1 assoluta stabilita' con lambda=-4
% h in [0.01, 0.1, 0.5, 1]
close all % chiude tutte le figure aperte prima
% definisco i dati
clear i
lambda=i;
odefun=@(t,y)lambda*y;
tspan=[0,100];
y0=1;
% scelgo il metodo
metodo=menu('scegli il metodo','EE','EI','CN','Heun');

if metodo ==1
% calcolo h0 per Eulero esplicito
   h0=-2*real(lambda)/abs(lambda)^2
end

%H=[0.01,0.1,0.5,1]; 
H=[0.01,0.1];
figure(1); clf
k=0;
for h=H
    k=k+1;
    % definisco Nh =(T-t0)/h
    Nh=fix((tspan(2)-tspan(1))/h);
    if metodo ==1
        % chiamo EE
        [tn,un]=eulero_esp(odefun,tspan,y0,Nh);
    elseif metodo ==2
        [tn,un]=eulero_imp(odefun,tspan,y0,Nh);
    elseif metodo ==3
        [tn,un]=cranknicolson(odefun,tspan,y0,Nh);
    elseif metodo ==4
        [tn,un]=heun(odefun,tspan,y0,Nh);
    end

    subplot(2,2,k)
    plot(tn,un,'.--')
    grid on
    xlabel('t')
    ylabel('u_n')
    title(['h=',num2str(h)])
end