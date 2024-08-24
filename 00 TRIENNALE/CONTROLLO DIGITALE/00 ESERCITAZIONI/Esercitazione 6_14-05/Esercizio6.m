clear 
close all
clc

%Comando c2d che eprmette di calcolare serie ZOH e Campionatore

num= [1 0 0.5];
den1= [1 -0.1];
den2= [1 -0.8];

den= conv(den1, den2);

Tc=0.1;

sys_d=tf(num, den, Tc);  %Sistema tempo discreto





% Calcolo equazione alle differenze su quaderno