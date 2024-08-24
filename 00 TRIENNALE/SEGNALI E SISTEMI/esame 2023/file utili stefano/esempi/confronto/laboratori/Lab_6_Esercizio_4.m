clc
clear
close all

dt=0.01;
df=0.01;
t=-10:dt:10;
f=-15:df:15;
addpath ../../0.FUNZIONI/

x=(1/2)*t.^3+5*t.^2-2*(t+10).^2+20;

b=[2,4,8,16];

xq=zeros(length(b),length(t));

for i=1:length(b)
    xq(i,:)=myQuant(x,b(i));
end

figure('name','Segnale quantizzato')
subplot(2,2,1); title('2 bit','Interpreter','latex','FontSize',15); grid on;
hold on
plot(t,xq(1,:),LineWidth=2,Color='red'); 
plot(t,x,LineWidth=2,Color='black'); 
hold off
subplot(2,2,2); title('4 bit','Interpreter','latex','FontSize',15); grid on; 
hold on
plot(t,xq(2,:),LineWidth=2,Color='red'); 
plot(t,x,LineWidth=2,Color='black'); 
hold off
subplot(2,2,3); title('8 bit','Interpreter','latex','FontSize',15); grid on;
hold on
plot(t,xq(3,:),LineWidth=2,Color='red'); 
plot(t,x,LineWidth=2,Color='black'); 
hold off
subplot(2,2,4); title('16 bit','Interpreter','latex','FontSize',15); grid on;
hold on
plot(t,x,LineWidth=2,Color='black'); 
plot(t,xq(4,:),LineWidth=2,Color='red'); 
hold off
pause
close

err=zeros(length(b),length(t));

for i=1:length(b)
    err(i,:)=x-xq(i,:);
end

E=zeros(length(b));

for i=1:length(b)
    E(i)=integrale(abs(err(i,:).^2),dt);
end

fprintf('Potenza media errore con 2 bit: %f\n',E(1));
fprintf('Potenza media errore con 4 bit: %f\n',E(2));
fprintf('Potenza media errore con 8 bit: %f\n',E(3));
fprintf('Potenza media errore con 16 bit: %f\n',E(4));