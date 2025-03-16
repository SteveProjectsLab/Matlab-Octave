% es1 assoluta stabilita' con lambda=-4
clear 
close all
clc
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

%% calcolo la soluzione esatta
syms y(t)
ode=diff(y,t)==lambda*y;
cond= y(0)==1;
yexx(t)=dsolve(ode,cond);
yex=matlabFunction(yexx(t));
% risulta yex(t) =exp(t*1i)
figure(1)
t=linspace(tspan(1),tspan(2),1e3);



%% 
if metodo ==1
% calcolo h0 per Eulero esplicito
   h0=-2*real(lambda)/abs(lambda)^2
end

H=[0.01,0.1];
figure(1); clf
a=0;
for h=H
    
    % definisco Nh =(T-t0)/h
    Nh=fix((tspan(2)-tspan(1))/h);
    if metodo ==1
        [tn,un]=eulero_esp(odefun,tspan,y0,Nh);
        titleName='EE';
    elseif metodo ==2
        [tn,un]=eulero_imp(odefun,tspan,y0,Nh);
        titleName='EI';
    elseif metodo ==3
        [tn,un]=cranknicolson(odefun,tspan,y0,Nh);
        titleName='CN';
    elseif metodo ==4
        [tn,un]=heun(odefun,tspan,y0,Nh);
        titleName='Heun';
    end

    hold on
    subplot(2,1,1)
    if a==0
        plot(t,real(yex(t)),'DisplayName','soluzione esatta')
        hold on
    end
    plot(tn,real(un),'.--','DisplayName',['h=',num2str(h)])
    hold on; grid on;legend('-dynamicLegend')
    title(titleName )
    hold on
    xlabel('t')
    ylabel('real')
    subplot(2,1,2)
    if a==0
        plot(t,imag(yex(t)),'DisplayName','soluzione esatta')
        hold on
    end
    hold on
    plot(tn,imag(un),'.--','DisplayName',['h=',num2str(h)])
    grid on;grid on;legend('-dynamicLegend')

    xlabel('t')
    ylabel('imag')
    
   
    a=a+1;
end

    % if metodo ==1
    %     verify_stability(1,0.01,lambda,100)
    % elseif metodo ==2
    %     verify_stability(2,0.01,lambda,100)
    % elseif metodo ==3 
    %     verify_stability(3,0.01,lambda,100)
    % end