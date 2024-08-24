clear
close all
clc

dt=0.01;
t=-10:dt:10;
dtau=dt;
tau=-15:dtau:15;
df=0.01;
f= -15:df:15;

fprintf('TITOLO DA INSERIRE \n\n');

r=3;
c=2;

%                GRAFICI
figure(1);
subplot(r,c,1)
plot(t,x)
title('segnale: rect(t)')
set(count, 'WindowStyle', 'docked')
axis([min(t) max(t) min(gradino(t))-.25 max(gradino(t))+.25])
grid on