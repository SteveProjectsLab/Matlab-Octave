dt=0.01;
df=0.01;
t=-10:dt:10;
f=-15:df:15;
%addpath /Users/nicolatrotti/Desktop/MATLAB/SEGNALI/0.FUNZIONI/

x1=rect(t);
X1=trasFourier(x1,t,f);
inv_X1=invTrasFourier(X1,f,t);

x2=tri(t);
X2=trasFourier(x2,t,f);
inv_X2=invTrasFourier(X2,f,t);

x3=exp(-pi*t.^2);
X3=trasFourier(x3,t,f);
inv_X3=invTrasFourier(X3,f,t);

x4=cos(4*pi*t);
X4=trasFourier(x4,t,f);
inv_X4=invTrasFourier(X4,f,t);

figure('name','Trasformate e Antitrasformate')
subplot(4,3,1); plot(t,x1,LineWidth=2,Color='red'); title('$$x_1(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(4,3,2); plot(f,abs(X1),LineWidth=2,Color='red'); title('$$|X_1(f)|$$','Interpreter','latex','FontSize',15); grid on;
subplot(4,3,3); plot(f,unwrap(angle(X1)),LineWidth=2,Color='red'); title('$$<X_1(f)$$','Interpreter','latex','FontSize',15); grid on;
subplot(4,3,4); plot(t,x2,LineWidth=2,Color='blue'); title('$$x_2(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(4,3,5); plot(f,abs(X2),LineWidth=2,Color='blue'); title('$$|X_2(f)|$$','Interpreter','latex','FontSize',15); grid on;
subplot(4,3,6); plot(f,unwrap(angle(X2)),LineWidth=2,Color='blue'); title('$$<X_2(f)$$','Interpreter','latex','FontSize',15); grid on;
subplot(4,3,7); plot(t,x3,LineWidth=2,Color='black'); title('$$x_3(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(4,3,8); plot(f,abs(X3),LineWidth=2,Color='black'); title('$$|X_3(f)|$$','Interpreter','latex','FontSize',15); grid on;
subplot(4,3,9); plot(f,unwrap(angle(X3)),LineWidth=2,Color='black'); title('$$<X_3(f)$$','Interpreter','latex','FontSize',15); grid on;
subplot(4,3,10); plot(t,x4,LineWidth=2,Color='green'); title('$$x_4(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(4,3,11); plot(f,abs(X4),LineWidth=2,Color='green'); title('$$|X_4(f)|$$','Interpreter','latex','FontSize',15); grid on;
subplot(4,3,12); plot(f,unwrap(angle(X4)),LineWidth=2,Color='green'); title('$$<X_4(f)$$','Interpreter','latex','FontSize',15); grid on;





