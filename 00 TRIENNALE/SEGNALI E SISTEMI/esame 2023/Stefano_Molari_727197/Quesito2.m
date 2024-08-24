% per verificare la funzione "diodo(x)"
clear all
clc
close all
dt=0.01;
t=-10:dt:10;

fprintf('test diodo con a=0.2\n')

x1=0.1*rect(t)+0.3*rect(t-5);
x2=0.5*rect(t)+0.3*rect(t-5);

subplot(2,3,1); plot(t,x1); title('x1(t)'); grid on;
subplot(2,3,2); plot(t,x2); title('x2(t)'); grid on;
subplot(2,3,3); plot(t,diodo(x1+x2));title('S[x1(t)+x2(t)]'); grid on;

subplot(2,3,4); plot(t,diodo(x1)); title('s[x1(t)]'); grid on;
subplot(2,3,5); plot(t,diodo(x2)); title('s[x2(t)]'); grid on;
subplot(2,3,6); plot(t,diodo(x1)+diodo(x2));title('S[x1(t)]+s[x2(t)]'); grid on;

% si può notare dal graficpo che non è lineare



fprintf("\npremere un tasto per continuare\n")
pause; 
clc
close all