% y1=y
% y2=y'=y1'
% y3=y''=y2'

% y1'=y2
% y2'=y3
% y3'=1/2(-3*y3-3y2+3y1+sin(t))
clc
close all
clear

H=[0.01,1.8,1.9,2,2.1,2.2,2.2,2.3,2.4,999999999999999];

% odefun=@(t,y)[y(2);
%      y(3);
%     0.5*(-2*y(3)-3*y(2)-3*y(1)+sin(t))];

A=[0 1 0;
    0 0 1;
    -1.5 -1.5 -1];


odefun=@(t,y)A*y;

tspan=[0,40];
y0=[1;-2;4]

for h=H
    Nh=fix((tspan(2)-tspan(1))/h);


    [tn4,un4]=rk4(odefun,tspan,y0,Nh);
    plot(tn4,un4(:,1),'-..','DisplayName',['RKh=',num2str(h)]);
    hold on;
    grid on
    xlabel('t')
    ylabel('i_1(t)')
    legend('-dynamiclegend')
    pause
end

lambda=eig(A)


% eulero eplicito produrrà sempre delle socillazioni
% al contrario RK c'è un pezzo immaginario

% richiedo h<2.7 per lambda reale
% e h<2.2 per lambda immaginari
% prendo h più piccolo

% per garantire assoluta stabilità prendo h<2.2 circa



% riascolta reg
% 2 ore esame
