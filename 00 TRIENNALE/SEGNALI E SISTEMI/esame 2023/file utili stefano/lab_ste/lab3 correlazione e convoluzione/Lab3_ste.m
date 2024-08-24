% SEGNALI E SISTEMI
% Laboratorio Matlab del 29/03/2023

clear
close all
clc
dt = 0.01;
dtau=dt;
t = -10:dt:10;
tau = -15:dtau:15; 
%-------------------------------------------------------------------------
% ***************
% * ESERCIZIO 1 *
% ***************
%-------------------------------------------------------------------------
fprintf('ES1 Punto 1 2 3 calcolo autocorrelazione rect\n\n');
%-------------------------------------------------------------------------
 x = rect(t);
 y = tri(t);
 p = rect(t-1/2)-rect(t-3/2);
 yc = 1i*tri(t+1);

cr_xx=myCrossCorrelazioneLineare(x,x,t,tau,dt);
cr_xy=myCrossCorrelazioneLineare(x,y,t,tau,dt);
cr_pp=myCrossCorrelazioneLineare(p,p,t,tau,dt);
cr_xyc=myCrossCorrelazioneLineare(x,yc,t,tau,dt);

figure(1),set(1, 'WindowStyle', 'docked'), plot(tau,real(cr_xx)), hold on
plot(tau,imag(cr_xx),'r--'), title('cross correlazione xx')
figure(2),set(2, 'WindowStyle', 'docked'), plot(tau,real(cr_xy)), hold on
plot(tau,imag(cr_xy),'r--'), title('cross correlazione xy')
figure(3),set(3, 'WindowStyle', 'docked'), plot(tau,real(cr_pp)), hold on
plot(tau,imag(cr_pp),'r--'), title('cross correlazione pp')
figure(4),set(4, 'WindowStyle', 'docked'), plot(tau,real(cr_xyc)), hold on
plot(tau,imag(cr_xyc),'r--'), title('cross correlazione xyc')

fprintf("\npremere un tasto per continuare")
pause; 
clc
close all
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
% ***************
% * ESERCIZIO 2 *
% ***************
%-------------------------------------------------------------------------
% Svolgiamo il caso (iv) come esempio, cambiare i segnali per ottenere gli
% altri casi o vedere soluzione inline sottostante
fprintf('ES2 Punto 1-5 calcolo convoluzione \n\n');
%-------------------------------------------------------------------------
x=rect(t);
h=rect(t);
conv1=myConvoluzione(x,h,t);

x=rect(t);
h=tri(t);
conv2=myConvoluzione(x,h,t);

x=rect(t);
h=1j*tri(t+1);
conv3=myConvoluzione(x,h,t);

x=rect(t-2);
h=exp(-t).*gradino(t);
conv4=myConvoluzione(x,h,t);

x=rect(t/2);
h=sinc(5*t);
conv5=myConvoluzione(x,h,t);

figure(5),set(5, 'WindowStyle', 'docked'), 
plot(t,conv1);
figure(6),set(6, 'WindowStyle', 'docked'), 
plot(t,conv2);
figure(7),set(7, 'WindowStyle', 'docked'), plot(t,real(conv3)), hold on
plot(t,imag(conv3),'r--');
figure(8),set(8, 'WindowStyle', 'docked'), 
plot(t,conv4);

fprintf("\npremere un tasto per continuare")
pause; 
clc
close all