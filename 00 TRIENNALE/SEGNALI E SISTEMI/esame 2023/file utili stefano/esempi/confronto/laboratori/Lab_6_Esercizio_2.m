clc
clear
close all

dt=0.01;
df=0.01;
t=-10:dt:10;
f=-15:df:15;
addpath ../../0.FUNZIONI/

x2=4*exp(-10*t.^2);

X2=trasFourier(x2,t,f);

figure('name','x2 e X2')
subplot(2,1,1); plot(t,x2,LineWidth=2,Color='red'); title('$$4*exp(-10*t.^2)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,1,2); plot(f,abs(X2),LineWidth=2,Color='black'); title('TDF $$4*exp(-10*t.^2)$$','Interpreter','latex','FontSize',15); grid on; axis([-3 3 -2 18]);
pause
close 

Tc=[10*dt 20*dt 30*dt 40*dt 50*dt];
x2c=zeros(length(Tc),length(t));

for i=1:length(Tc)
    x2c(i,:)=myCamp(x2,Tc(i),t);
end

figure('name','Segnale campionato')
subplot(3,2,1); plot(t,x2c(1,:),LineWidth=2,Color='red'); title('x2c con Tc = 10*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,2); plot(t,x2c(2,:),LineWidth=2,Color='black'); title('x2c con Tc = 20*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,3); plot(t,x2c(3,:),LineWidth=2,Color='blue'); title('x2c con Tc = 30*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,4); plot(t,x2c(4,:),LineWidth=2,Color='green'); title('x2c con Tc = 40*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,5); plot(t,x2c(5,:),LineWidth=2,Color='cyan'); title('x2c con Tc = 50*dt','Interpreter','latex','FontSize',15); grid on;
pause
close 

X2c=zeros(length(Tc),length(f));

for i=1:length(Tc)
    X2c(i,:)=(1/dt)*trasFourier(x2c(i,:),t,f);
end  

figure('name','TDF segnale campionato')
subplot(3,2,1); plot(f,abs(X2c(1,:)),LineWidth=2,Color='red'); title('X2c con Tc = 10*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,2); plot(f,abs(X2c(2,:)),LineWidth=2,Color='black'); title('X2c con Tc = 20*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,3); plot(f,abs(X2c(3,:)),LineWidth=2,Color='blue'); title('X2c con Tc = 30*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,4); plot(f,abs(X2c(4,:)),LineWidth=2,Color='green'); title('X2c con Tc = 40*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,5); plot(f,abs(X2c(5,:)),LineWidth=2,Color='cyan'); title('X2c con Tc = 50*dt','Interpreter','latex','FontSize',15); grid on;
pause
close 

% INTERPOLATORE IDEALE

x2i=zeros(length(Tc),length(t));
for i=1:length(Tc)
    for k=-length(t):1:length(t)
        x2i(i,:)= x2i(i,:)+x2c(i,:).*sinc(t/Tc(i)-k);
    end
end

% MANTENITORE IDEALE

x2m=zeros(length(Tc),length(t));
for i=1:length(Tc)
    for k=-length(t):1:length(t)
        x2m(i,:)= x2m(i,:)+x2c(i,:).*rect(t/Tc(i)-k);
    end
end

figure('name','Segnale ricostruito con interpolazione ideale')
subplot(3,2,1); plot(t,real(x2i(1,:)),LineWidth=2,Color='red'); title('x2i con Tc = 10*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,2); plot(t,real(x2i(2,:)),LineWidth=2,Color='black'); title('x2i con Tc = 20*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,3); plot(t,real(x2i(3,:)),LineWidth=2,Color='blue'); title('x2i con Tc = 30*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,4); plot(t,real(x2i(4,:)),LineWidth=2,Color='green'); title('x2i con Tc = 40*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,5); plot(t,real(x2i(5,:)),LineWidth=2,Color='cyan'); title('x2i con Tc = 50*dt','Interpreter','latex','FontSize',15); grid on;
pause
close 

figure('name','Segnale ricostruito con mantenitore')
subplot(3,2,1); plot(t,real(x2m(1,:)),LineWidth=2,Color='red'); title('x2m con Tc = 10*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,2); plot(t,real(x2m(2,:)),LineWidth=2,Color='black'); title('x2m con Tc = 20*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,3); plot(t,real(x2m(3,:)),LineWidth=2,Color='blue'); title('x2m con Tc = 30*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,4); plot(t,real(x2m(4,:)),LineWidth=2,Color='green'); title('x2m con Tc = 40*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,5); plot(t,real(x2m(5,:)),LineWidth=2,Color='cyan'); title('x2m con Tc = 50*dt','Interpreter','latex','FontSize',15); grid on;
pause
close 
