close all
clc
set(0,'DefaultFigureWindowStyle','docked');

Fext=@(t)sin(t);
R=0.2;
K=0.8;
m=0.5;
x0=1;

%odefun=@(t,y)[1/C*(y(2)-y(1)/R2);   1/L*(-y(2)*R1-y(1)+e)];
A=[0,1;-K/m,-R/m]
g=@(t)[0;Fext(t)/m]
odefun=@(t,y)A*y+g(t);

tspan=[0,30];
y0=[x0;0];

H=[0.1,0.4,0.8,1];
%H=[0.01,0.86,0.88,0.9, 0.92, 0.94];% per capire l'h0

% dai risultati numerici confermo che h0 è circa 0.9
% h=0.008 all'inizio oscilla c'è assoluta stabilità
% h=0.011 alla fine manca assoluta stabilità

k=0;

for h=H
    Nh=fix((tspan(2)-tspan(1))/h);
    [tn,un]=ab3am4(odefun,tspan,y0,Nh);
    plot(tn,un(:,1),'-..','DisplayName',['h=',num2str(h)]);
    hold on;
    grid on
    xlabel('t')
    ylabel('i_1(t)')
    legend('-dynamiclegend')
    pause
end

% calcolo autovalori
lambda=eig(A)



% calcolo l'h0 per ciacuno dei due autovalori
h0=-2*real(lambda)./(abs(lambda).^2)


% dovremmo prendere il più piccolo nel caso non fossero complessi coniugati

% h0 >= h0 non è garantito di avere assoluta stabilità

% g non va a influire sulla scelta di h per avere assoluta stabilità