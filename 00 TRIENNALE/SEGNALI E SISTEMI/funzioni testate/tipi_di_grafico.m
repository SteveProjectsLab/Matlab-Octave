clear
close all
clc
dt=0.01;
t=-10:dt:10;
dtau=dt;
tau=-15:dtau:15;
df=0.01;
f= -15:df:15;

x1 = 4*rect((t-3)/10);
x2 = 3*tri((t+1)/4);
x3 = gradino(-t+2);
%-------------------------------------------------------------------------
% 1 grafico - 1 segnale
figure(1), title('1 grafico - 1 segnale'),set(1, 'WindowStyle', 'docked');

plot(t,x1),legend('x1'), grid on;

%-------------------------------------------------------------------------
% 1 grafico - più segnali
figure(2), title('1 grafico - più segnali'),set(2, 'WindowStyle', 'docked');

plot(t,x1), grid on;hold on;
plot(t,x2), grid on;hold on;
plot(t,x3), grid on;hold on;
legend('x1','x2','x3');
hold off;

%-------------------------------------------------------------------------
% subplot

x1 = rect(t);
X1 = T_Fourier(x1,t,f);
inv_x1 = Inv_T_Fourier(X1,f,t);

x2 = tri(t);
X2 = T_Fourier(x2,t,f);
inv_x2 = Inv_T_Fourier(X2,f,t);

x3 = exp(-pi*t.^2);
X3 = T_Fourier(x3,t,f);
inv_x3 = Inv_T_Fourier(X3,f,t);

figure(3), title('subplot'),set(3, 'WindowStyle', 'docked');

subplot(3,3,1); plot(t,x1); title('x1(t)'); grid on;
subplot(3,3,2); plot(f,real(X1)); title('X1(f)');  grid on;
subplot(3,3,3); plot(t,real(inv_x1));title('x1(t) da tdf'); grid on;
subplot(3,3,4); plot(t,x2); title('x2(t)');  grid on;
subplot(3,3,5); plot(f,real(X2)); title('X2(f)'); grid on;
subplot(3,3,6); plot(t,real(inv_x2));title('x2(t) da tdf'); grid on;
subplot(3,3,7); plot(t,x3); title('x3(t)');  grid on;
subplot(3,3,8); plot(f,real(X3)); title('X3(f)'); grid on;
subplot(3,3,9); plot(t,real(inv_x3));title('x3(t) da tdf'); grid on;

