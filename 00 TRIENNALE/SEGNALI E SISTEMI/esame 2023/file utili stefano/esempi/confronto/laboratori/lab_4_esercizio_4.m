dt=0.01;
df=0.01;
t=-10:dt:10;
f=-15:df:15;
%addpath /Users/nicolatrotti/Desktop/MATLAB/SEGNALI/0.FUNZIONI/

x1=sinc(5*t);
X1=trasFourier(x1,t,f);

x2=sinc(5*(t-1/2));
X2=trasFourier(x2,t,f);

x3=sinc(5*(t+1));
X3=trasFourier(x3,t,f);

x4=((sinc(t)).^2).*cos(10*pi*t);
X4=trasFourier(x4,t,f);

x5=sinc(t).*(cos(10*pi*t)).^2;
X5=trasFourier(x5,t,f);

figure(1)
subplot(3,1,1); plot(t,x1,LineWidth=2,Color='red'); title('$$x_1(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(f,real(X1),LineWidth=2,Color='black'); title('$$Re{X1(f)}$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(f,imag(X1),LineWidth=2,Color='blue'); title('$$Im{X1(f)}$$','Interpreter','latex','FontSize',15); grid on;
pause

figure(2)
subplot(3,1,1); plot(t,x2,LineWidth=2,Color='red'); title('$$x_2(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(f,real(X2),LineWidth=2,Color='black'); title('$$Re{X2(f)}$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(f,imag(X2),LineWidth=2,Color='blue'); title('$$Im{X2(f)}$$','Interpreter','latex','FontSize',15); grid on;
pause

figure(3)
subplot(3,1,1); plot(t,x3,LineWidth=2,Color='red'); title('$$x_3(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(f,real(X3),LineWidth=2,Color='black'); title('$$Re{X3(f)}$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(f,imag(X3),LineWidth=2,Color='blue'); title('$$Im{X3(f)}$$','Interpreter','latex','FontSize',15); grid on;
pause

figure(4)
subplot(3,1,1); plot(t,x4,LineWidth=2,Color='red'); title('$$x_4(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(f,real(X4),LineWidth=2,Color='black'); title('$$Re{X4(f)}$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(f,imag(X4),LineWidth=2,Color='blue'); title('$$Im{X4(f)}$$','Interpreter','latex','FontSize',15); grid on;
pause

figure(5)
subplot(3,1,1); plot(t,x5,LineWidth=2,Color='red'); title('$$x_5(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(f,real(X5),LineWidth=2,Color='black'); title('$$Re{X5(f)}$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(f,imag(X5),LineWidth=2,Color='blue'); title('$$Im{X5(f)}$$','Interpreter','latex','FontSize',15); grid on;
pause
