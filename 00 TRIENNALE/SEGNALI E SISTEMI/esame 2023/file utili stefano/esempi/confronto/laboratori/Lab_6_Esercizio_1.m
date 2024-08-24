clc
clear
close all

dt=0.01;
df=0.01;
t=-10:dt:10;
f=-15:df:15;
addpath ../../0.FUNZIONI/

x1=8*sinc(t/2);

figure('name','x1 e X1')
subplot(2,1,1); plot(t,x1,LineWidth=2,Color='red'); title('$$8sinc(t/2)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,1,2); plot(f,abs(trasFourier(x1,t,f)),LineWidth=2,Color='black'); title('TDF $$8sinc(t/2)$$','Interpreter','latex','FontSize',15); grid on; axis([-3 3 -2 18]);
pause
close 

Tc=[10*dt 20*dt 30*dt 40*dt 50*dt];
x1c=zeros(length(Tc),length(t));

for i=1:length(Tc)
    x1c(i,:)=myCamp(x1,Tc(i),t);
end

figure('name','Segnale campionato')
subplot(3,2,1); plot(t,x1c(1,:),LineWidth=2,Color='red'); title('x1c con Tc = 10*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,2); plot(t,x1c(2,:),LineWidth=2,Color='black'); title('x1c con Tc = 20*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,3); plot(t,x1c(3,:),LineWidth=2,Color='blue'); title('x1c con Tc = 30*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,4); plot(t,x1c(4,:),LineWidth=2,Color='green'); title('x1c con Tc = 40*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,5); plot(t,x1c(5,:),LineWidth=2,Color='cyan'); title('x1 con Tc = 50*dt','Interpreter','latex','FontSize',15); grid on;
pause
close 

X1c=zeros(length(Tc),length(f));


for i=1:length(Tc)
    X1c(i,:)=(1/dt)*trasFourier(x1c(i,:),t,f);
end  

figure('name','TDF segnale campionato')
subplot(3,2,1); plot(f,abs(X1c(1,:)),LineWidth=2,Color='red'); title('X1c con Tc = 10*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,2); plot(f,abs(X1c(2,:)),LineWidth=2,Color='black'); title('X1c con Tc = 20*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,3); plot(f,abs(X1c(3,:)),LineWidth=2,Color='blue'); title('X1c con Tc = 30*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,4); plot(f,abs(X1c(4,:)),LineWidth=2,Color='green'); title('X1c con Tc = 40*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,5); plot(f,abs(X1c(5,:)),LineWidth=2,Color='cyan'); title('X1c con Tc = 50*dt','Interpreter','latex','FontSize',15); grid on;
pause
close 

% INTERPOLATORE IDEALE

x1i=zeros(length(Tc),length(t));
for i=1:length(Tc)
    for k=-length(t):1:length(t)
        x1i(i,:)= x1i(i,:)+x1c(i,:).*sinc(t/Tc(i)-k);
    end
end

% MANTENITORE IDEALE

x1m=zeros(length(Tc),length(t));
for i=1:length(Tc)
    for k=-length(t):1:length(t)
        x1m(i,:)= x1m(i,:)+x1c(i,:).*rect(t/Tc(i)-k);
    end
end

figure('name','Segnale ricostruito con interpolazione ideale')
subplot(3,2,1); plot(t,real(x1i(1,:)),LineWidth=2,Color='red'); title('x1i con Tc = 10*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,2); plot(t,real(x1i(2,:)),LineWidth=2,Color='black'); title('x1i con Tc = 20*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,3); plot(t,real(x1i(3,:)),LineWidth=2,Color='blue'); title('x1i con Tc = 30*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,4); plot(t,real(x1i(4,:)),LineWidth=2,Color='green'); title('x1i con Tc = 40*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,5); plot(t,real(x1i(5,:)),LineWidth=2,Color='cyan'); title('x1i con Tc = 50*dt','Interpreter','latex','FontSize',15); grid on;
pause
close 

figure('name','Segnale ricostruito con mantenitore')
subplot(3,2,1); plot(t,real(x1m(1,:)),LineWidth=2,Color='red'); title('x1m con Tc = 10*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,2); plot(t,real(x1m(2,:)),LineWidth=2,Color='black'); title('x1m con Tc = 20*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,3); plot(t,real(x1m(3,:)),LineWidth=2,Color='blue'); title('x1m con Tc = 30*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,4); plot(t,real(x1m(4,:)),LineWidth=2,Color='green'); title('x1m con Tc = 40*dt','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,5); plot(t,real(x1m(5,:)),LineWidth=2,Color='cyan'); title('x1m con Tc = 50*dt','Interpreter','latex','FontSize',15); grid on;
pause
close 
