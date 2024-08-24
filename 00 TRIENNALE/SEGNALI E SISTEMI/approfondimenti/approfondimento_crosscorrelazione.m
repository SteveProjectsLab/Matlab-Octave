clear
close all
clc

dt=0.01;
t=-10:dt:10;
dtau=dt;
tau=-15:dtau:15;
df=0.01;
f= -15:df:50;


%x= rect(t-1/2);

%y=rect((t-3)/4);

x=tri(t-1);
y=rect(t-1/2);
% voglio fare vedere che la cross correlazione non è commutativa

figure(1);
subplot(3,1,1);
plot(t,x,'r');title("segnali");grid on; hold on;
axis([min(t) max(t) 0 4])
plot(t,y,'b');grid on; hold on;
hold off;
z1=myCrossCorrelazioneLineare(x,y,t,tau,dt);
z2=myCrossCorrelazioneLineare(y,x,t,tau,dt);

subplot(3,1,2);
plot(tau,z1,'r');grid on; title("cross correlazione xy");
axis([min(t) max(t) min(z2)-0.2 max(z2)+0.2])

subplot(3,1,3);
plot(tau,z2,'r');grid on; title("cross correlazione yx");
axis([min(t) max(t) min(z2)-0.2 max(z2)+0.2])
%plot(tau,z2,'b'); hold on;