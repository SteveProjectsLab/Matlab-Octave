%            ES2               MOLARI STEFANO 727197				03/03/2022
close
clear all
clc

num = 10;

den = conv([ 1 1], [1/100 1]);

sys_1= tf(num, den);

[z,p,k]=zpkdata(sys_1, 'v'); % 'v' è per la forma vettoriale

figure(1)
subplot(1,2,1);
bode(sys_1);
subplot(1,2,2);
nyquist(sys_1);

[Gm,Pm,Wcg,Wcp] = margin(sys_1);
