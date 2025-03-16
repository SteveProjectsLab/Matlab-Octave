% testo il gradiente e il gradiente coniugato
clear
close all
clc

A=[6 1 -2 2 1;
    1 3 1 -2 0;
    -2 1 4 -1 -1;
    2 -2 -1 4 2;
    1 0 -1 2 3];
b=[15;2;3;21;21];
x0=rand(5,1);
tol=1e-12;
kmax=500;


[x,res,k1,resvec]=gradiente(A,b,x0,tol,kmax)

[x1,res1,k2,resvec1]=gradiente_coniugato(A,b,x0,tol,kmax)

[x2,res2,k3,resvec2]=bcgstab(A,b,x0,tol,kmax)

%% rappresento l'andamento degli errori

set(0,'DefaultFigureWindowStyle','docked')

figure(1); clf
grid on
semilogy((0:k1)', resvec,'DisplayName','G','Color','r','LineWidth',2)
hold on
semilogy((0:k2)', resvec1,'DisplayName','GC','Color','k','LineWidth',2)
hold on
semilogy((0:k3)', resvec2,'DisplayName','BICGStab','Color','b','LineWidth',2)

xlabel('k')
ylabel('norma del residuo')
legend('-dynamicLegend')
title('caso in cui x0 faccia convergere G e GC anche se A non è SDP')

%% 
x0=rand(500,1);

tol=1e-12;
kmax=500;

figure(2); clf
semilogy((0:k1)',resvec,'Linewidth',2,'Displayname','gradiente')
legend('-dynamiclegend')
hold on
semilogy((0:k2)',resvec1,'Linewidth',2,'Displayname','GC')
semilogy((0:k3)',resvec2,'Linewidth',2,'Displayname','Bcgstab')
grid on
xlabel('iterazione')
ylabel('norma del residuo')
%title('vettore iniziale random,\n non per forza G e GC convergono perchè A non è sdp')