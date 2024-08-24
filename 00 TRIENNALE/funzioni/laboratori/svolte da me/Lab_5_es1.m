clear
close all
clc

dt = 0.01;      %
t = -10:dt:10;  %vettore dei tempi
df = 0.01;      %
f = -15:df:15;  %vettore delle frequenze


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%verificare la proprietà di traslazione della tdf

x1=sinc(5*t);
x2=sinc(5*(t-0.5));
x3=sinc(5*(t+1));

X1=myFourier(x1,t,f);
X2=myFourier(x2,t,f);
X3=myFourier(x3,t,f);
fprintf('\n\nLAB 5 es 1.1\n\n');

%verifico tramite parte reale e immaginaria

figure(1),set(1, 'WindowStyle', 'docked')
subplot(2,3,1),plot(f,real(X1)),title('X1 real'),grid on
subplot(2,3,2),plot(f,real(X2)),title('X2 real'),grid on
subplot(2,3,3),plot(f,real(X3)),title('X3 real'),grid on
subplot(2,3,4),plot(f,imag(X1)),title('X1 imag'),grid on
subplot(2,3,5),plot(f,imag(X2)),title('X2 imag'),grid on
subplot(2,3,6),plot(f,imag(X3)),title('X3 imag'),grid on

%verifico tramite modulo e fase

figure(2),set(2, 'WindowStyle', 'docked')
subplot(3,1,1),plot(f,abs(X1),f,angle(X1)),title('X1 '),legend('Modulo','fase'),grid on
subplot(3,1,2),plot(f,abs(X2),f,angle(X2)),title('X2 '),legend('Modulo','fase'),grid on
subplot(3,1,3),plot(f,abs(X3 ),f,angle(X3)),title('X3 '),legend('Modulo','fase'),grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%verificare utilizzando la proprietà del prodotto

fprintf('\n\nLAB 5 es 1.2\n\n');

x4 = sinc(t).^2.*cos(10*pi*t);
X4 = T_Fourier(x4,t,f);
X4_calcolata = 0.5*tri(f-5) + 0.5*tri(f+5); 

figure(3),set(3, 'WindowStyle', 'docked')
subplot(1,2,1), plot(f,real(X4)), title('TdF calcolata via matlab'), axis([-10 10 0 1]),grid on
subplot(1,2,2), plot(f,real(X4_calcolata)), title('TdF calcolata analiticamente'), axis([-10 10 0 1]),grid on

x5 = sinc(t).*cos(10*pi*t).^2;
X5 = T_Fourier(x5,t,f);
X5_calcolata = 0.25*rect(f+10) + 0.5*rect(f) + 0.25*rect(f-10);

figure(4),set(4, 'WindowStyle', 'docked')
subplot(1,2,1), plot(f,real(X5)), title('TdF calcolata via matlab'), axis([-10 10 0 1]),grid on
subplot(1,2,2), plot(f,real(X5_calcolata)), title('TdF calcolata analiticamente'), axis([-10 10 0 1]),grid on

















