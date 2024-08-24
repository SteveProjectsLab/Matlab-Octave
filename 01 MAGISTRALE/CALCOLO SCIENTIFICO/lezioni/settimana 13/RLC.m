close all
set(0,'DefaultFigureWindowStyle','docked');
L=0.1;
R1=10;
R2=10; C=1e-3;
e=5;
%odefun=@(t,y)[1/C*(y(2)-y(1)/R2);   1/L*(-y(2)*R1-y(1)+e)];
A=[-1/(C*R2),1/C;-1/L,-R1/L]
g=[0;e];
odefun=@(t,y)A*y+g;
y0=[0;0];
tspan=[0,0.1];
%H=[0.001,0.005,0.01,0.02];
H=[0.008,0.011];
% h=0.008 all'inizio oscilla c'è assoluta stabilità
% h=0.011 alla fine manca assoluta stabilità
k=0;

for h=H
    k=k+1;
    Nh=fix((tspan(2)-tspan(1))/h);
    [tn,un]=eulero_esp_sys(odefun,tspan,y0,Nh);
    figure(k)
    subplot(2,2,1)
    plot(tn,un(:,1))
    grid on
    xlabel('t')
    ylabel('i_1(t)')
    
    subplot(2,2,2)
    plot(tn,un(:,2))
    grid on
    xlabel('t')
    ylabel('i_2(t)')


    subplot(2,2,3)
    plot(un(:,1),un(:,2))
    grid on
    xlabel('I_1(t)')
    ylabel('i_2(t)')
    hold on
    plot(y0(1),y0(2),'or','MarkerFaceColor','r')
    title(['h=',num2str(h)]);
end

% calcolo autovalori
lambda=eig(A)

% lambda =
% 
%    1.0e+02 *
% 
%   -1.0000 + 1.0000i
%   -1.0000 - 1.0000i

% calcolo l'h0 per ciacuno dei due autovalori
h0=-2*real(lambda)./(abs(lambda).^2)

% h0 =
% 
%     0.0100
%     0.0100

% dovremmo prendere il più piccolo nel caso non fossero complessi coniugati

% h0 >= h0 non è garantito di avere assoluta stabilità

% g non va a influire sulla scelta di h per avere assoluta stabilità