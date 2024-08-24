t = -10:0.01:10;
%addpath /Users/nicolatrotti/Desktop/MATLAB/SEGNALI/0.FUNZIONI/

x1 = 4*rect((t-3)/10);
x2 = 3*tri((t+1)/4);
x3 = gradino(-t+2);

figure('name','Segnali elementari')
subplot(3,1,1); plot(t,x1,LineWidth=2,Color='red'); title('$$x_1(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(t,x2,LineWidth=2,Color='black'); title('$$x_2(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(t,x3,LineWidth=2,Color='blue'); title('$$x_3(t)$$','Interpreter','latex','FontSize',15); grid on;
pause

x4 = x1+2*x2+3*x3;
x5 = x1.*x2.*x3;

figure('name','Combinazioni di segnali elementari')
subplot(2,1,1); plot(t,x4,LineWidth=2,Color='red'); title('$$x_1(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,1,2); plot(t,x5,LineWidth=2,Color='black'); title('$$x_2(t)$$','Interpreter','latex','FontSize',15); grid on;
pause

x6 = sin(t);
x7 = cos(2*pi*t);

figure('name','Seno e coseno')
subplot(2,1,1); plot(t,x6,LineWidth=2,Color='red'); title('$$x_6(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,1,2); plot(t,x7,LineWidth=2,Color='black'); title('$$x_7(t)$$','Interpreter','latex','FontSize',15); grid on;
pause

x8 = x6.*x7;
x9 = x6+x7;

figure('name','Combinazioni lineari di seno e coseno')
subplot(2,1,1); plot(t,x8,LineWidth=2,Color='red'); title('$$x_6(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,1,2); plot(t,x9,LineWidth=2,Color='black'); title('$$x_7(t)$$','Interpreter','latex','FontSize',15); grid on;
