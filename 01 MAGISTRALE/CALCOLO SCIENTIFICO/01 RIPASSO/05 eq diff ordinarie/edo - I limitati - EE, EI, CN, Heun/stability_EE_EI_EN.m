clear
close all
clc

odefun=@(t,y)-2*y
y0=1
tspan=[0,10]


%% calcolo la soluzione esatta utilizzando matlab
syms y(t)

ode= diff(y,t)==-2*y
cond = y(0) == 1;
sol_ex(t)=dsolve(ode,cond)  %sol_ex(t) = exp(-2*t);
% t=linspace(tspan(1),tspan(2),1000);
yex=matlabFunction(sol_ex);

% figure(1)
% plot(t,yex(t));
% title('soluzione esatta');

%% calcolo la soluzione con eulero esplicito
H=[0.01 0.1 1 2 ];
Err=[];
scelta=menu('scegli il metodo','EE','EI','CN');

figure(2)
i=0;
for h=H
    i=i+1;
    Nh=fix((tspan(2)-tspan(1))/h);
    if scelta==1
        titlename='Eulero Esplicito';
        [tn,un]=eulero_esp(odefun,tspan,y0,Nh);        
    elseif scelta==2
        titlename='Eulero Implicito';
        [tn,un]=eulero_imp(odefun,tspan,y0,Nh);
    elseif scelta==3
        titlename='CrankNicolson';
        [tn,un]=cranknicolson(odefun,tspan,y0,Nh);
    end
    subplot(2,2,i)
    plot(tn,un,'DisplayName',['h=',num2str(h)])
    title(titlename);
    
    hold on;grid on; legend('-dynamicLegend');
    err=max(abs(yex(tn)-un));
    Err=[Err,err];
    fprintf('h=%f,  errore=%e \n',h,err)
end


%% osservazioni


