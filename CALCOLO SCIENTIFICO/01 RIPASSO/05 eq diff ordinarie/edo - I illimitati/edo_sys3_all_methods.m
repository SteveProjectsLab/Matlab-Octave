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

%% calcolo gli autovalori di A

lambda=eig(A)
h0=-2*real(lambda)./abs(lambda).^2

%% risolvo 
%discretizzo
y0=[0;0];
tspan=[0,30];
H=[0.001, 0.005, 0.01, 0.02];
odeALL(odefun,tspan,y0,lambda,H)


