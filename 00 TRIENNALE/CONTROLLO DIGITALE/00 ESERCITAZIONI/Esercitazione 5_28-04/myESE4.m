clear 
close all
clc

%Comando c2d che permette di calcolare serie ZOH e Campionatore

num= [10 1];
den1= [1 1];
den2= [2 1];

den= conv(den1, den2);

sys_G=tf(num, den);  %Sistema tempo continuo

[z,p,k] = zpkdata(sys_G, 'v') 
Tv=1;
Tc=0.1*Tv;

sys_d = c2d(sys_G,Tc, 'zoh');