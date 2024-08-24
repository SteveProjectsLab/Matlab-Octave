clear 
close all
clc
set(0,'DefaultFigureWindowStyle','docked')
%% EE caso stabile
h=0.1;
lambda=-2+i;
plot_stability(1,h,lambda,1)

%% EE caso instabile
h=1;
lambda=-5+3*i;
plot_stability(1,h,lambda,2)

%% EI caso stabile
h=1;
lambda=-1+1/2*i
plot_stability(2,h,lambda,3)

%% EI caso instabile
h=0.5;
lambda=+1+i
plot_stability(2,h,lambda,4)

%% CN caso stabile
h=3;
lambda=-2+i
plot_stability(3,h,lambda,5)

%% CN caso instabile
h=3;
lambda=1+i
plot_stability(3,h,lambda,6)
%% Heun stabile
h=1;
lambda=-1+i
plot_stability(4,h,lambda,7)
%% Heun instabile
h=4;
lambda=-1+i
plot_stability(4,h,lambda,8)
%% RK4 stabile
h=1;
lambda=-1+i
plot_stability(5,h,lambda,9)
%% RK4 instabile
h=5;
lambda=-1+i
plot_stability(5,h,lambda,10)