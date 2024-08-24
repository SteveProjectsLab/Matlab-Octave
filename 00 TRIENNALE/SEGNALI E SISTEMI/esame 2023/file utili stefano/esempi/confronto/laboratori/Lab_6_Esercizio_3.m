clc
clear
close all

dt=0.01;
df=0.01;
t=-10:dt:10;
f=-15:df:15;
addpath ../../0.FUNZIONI/

x3=rect(t/sqrt(2));

X3=trasFourier(x3,t,f);

figure('name','x3 e X3')
subplot(2,1,1); plot(t,x3,LineWidth=2,Color='red'); title('$$rect(t/sqrt(2))$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,1,2); plot(f,abs(X3),LineWidth=2,Color='black'); title('TDF $$rect(t/sqrt(2))$$','Interpreter','latex','FontSize',15); grid on; axis([-3 3 -2 18]);
pause
close 

Tc=[10*dt 20*dt 30*dt 40*dt 50*dt];
x3c=zeros(length(Tc),length(t));

for i=1:length(Tc)
    x3c(i,:)=myCamp(x3,Tc(i),t);
end

figure('name','Segnale campionato')
subplot(3,2,1); plot(t,x3c(1,:),LineWidth=2,Color='red'); title('x3c con Tc = 10*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,2); plot(t,x3c(2,:),LineWidth=2,Color='black'); title('x3c con Tc = 20*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,3); plot(t,x3c(3,:),LineWidth=2,Color='blue'); title('x3c con Tc = 30*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,4); plot(t,x3c(4,:),LineWidth=2,Color='green'); title('x3c con Tc = 40*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,5); plot(t,x3c(5,:),LineWidth=2,Color='cyan'); title('x3c con Tc = 50*dt','Interpreter','latex','FontSize',15); grid on;
pause
close 

X3c=zeros(length(Tc),length(f));

for i=1:length(Tc)
    X3c(i,:)=(1/dt)*trasFourier(x3c(i,:),t,f);
end  

figure('name','TDF segnale campionato')
subplot(3,2,1); plot(f,abs(X3c(1,:)),LineWidth=2,Color='red'); title('X3c con Tc = 10*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,2); plot(f,abs(X3c(2,:)),LineWidth=2,Color='black'); title('X3c con Tc = 20*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,3); plot(f,abs(X3c(3,:)),LineWidth=2,Color='blue'); title('X3c con Tc = 30*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,4); plot(f,abs(X3c(4,:)),LineWidth=2,Color='green'); title('X3c con Tc = 40*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,5); plot(f,abs(X3c(5,:)),LineWidth=2,Color='cyan'); title('X3c con Tc = 50*dt','Interpreter','latex','FontSize',15); grid on;
pause
close 

% INTERPOLATORE IDEALE

x3i=zeros(length(Tc),length(t));
for i=1:length(Tc)
    for k=-length(t):1:length(t)
        x3i(i,:)= x3i(i,:)+x3c(i,:).*sinc(t/Tc(i)-k);
    end
end

% MANTENITORE IDEALE

x3m=zeros(length(Tc),length(t));
for i=1:length(Tc)
    for k=-length(t):1:length(t)
        x3m(i,:)= x3m(i,:)+x3c(i,:).*rect(t/Tc(i)-k);
    end
end

figure('name','Segnale ricostruito con interpolazione ideale')
subplot(3,2,1); plot(t,real(x3i(1,:)),LineWidth=2,Color='red'); title('x3i con Tc = 10*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,2); plot(t,real(x3i(2,:)),LineWidth=2,Color='black'); title('x3i con Tc = 20*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,3); plot(t,real(x3i(3,:)),LineWidth=2,Color='blue'); title('x3i con Tc = 30*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,4); plot(t,real(x3i(4,:)),LineWidth=2,Color='green'); title('x3i con Tc = 40*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,5); plot(t,real(x3i(5,:)),LineWidth=2,Color='cyan'); title('x3i con Tc = 50*dt','Interpreter','latex','FontSize',15); grid on;
pause
close 

figure('name','Segnale ricostruito con mantenitore')
subplot(3,2,1); plot(t,real(x3m(1,:)),LineWidth=2,Color='red'); title('x3m con Tc = 10*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,2); plot(t,real(x3m(2,:)),LineWidth=2,Color='black'); title('x3m con Tc = 20*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,3); plot(t,real(x3m(3,:)),LineWidth=2,Color='blue'); title('x3m con Tc = 30*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,4); plot(t,real(x3m(4,:)),LineWidth=2,Color='green'); title('x3m con Tc = 40*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,5); plot(t,real(x3m(5,:)),LineWidth=2,Color='cyan'); title('x3m con Tc = 50*dt','Interpreter','latex','FontSize',15); grid on;
pause
close 
