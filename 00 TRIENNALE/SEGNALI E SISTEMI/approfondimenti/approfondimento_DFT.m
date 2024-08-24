clear 
close all
clc

dt = 0.01;
df = 0.01;
t = -10:dt:10;
f = -10:df:10;

% SOVRACAMPIONAMENTO DTFT
x1 = [1,2,3,4];
x2 = [1,2,3,4,0,0,0,0];

n=[0:length(x1)-1];
k=[0:length(x2)-1];

X1 = my_DFT(x1);
X2 = my_DFT(x2);
%X1F = myFourier(t,t,f);
%X2F =myFourier(t,t,f);


figure(1)
subplot(2,2,1), stem(n,x1), title('x_1[n]'),grid on
subplot(2,2,3), stem(n,real(X1)), hold on, stem(n,imag(X1),'x'), title('X_1[k] con my DFT4'),grid on
subplot(2,2,2), stem(k,x2), title('x_2[n]'),grid on
subplot(2,2,4), stem(k,real(X2)), hold on, stem(k,imag(X2),'x'), title('X_2[k] con DFT8'),grid on


% FENOMENO DI ZERO INTERLEAVING doppio
x1 = [1,2,3,4];
x2 = [1,2,3,4,1,2,3,4];
n=[0:length(x1)-1];
k=[0:length(x2)-1];

X1 = my_DFT(x1);
X2 = my_DFT(x2);


figure(2)
subplot(2,2,1), stem(n,x1), title('x_1[n]'),grid on
subplot(2,2,3), stem(n,real(X1)), hold on, stem(n,imag(X1),'x'), title('X_1[k] con my DFT4'),grid on
subplot(2,2,2), stem(k,x2), title('x_2[n]'),grid on
subplot(2,2,4), stem(k,real(X2)), hold on, stem(k,imag(X2),'x'), title('X_2[k] con DFT8'),grid on

% FENOMENO DI ZERO INTERLEAVING triplo
x1 = [1,2,3,4];
x2 = [1,2,3,4,1,2,3,4,1,2,3,4];
n=[0:length(x1)-1];
k=[0:length(x2)-1];

X1 = my_DFT(x1);
X2 = my_DFT(x2);


figure(3)
subplot(2,2,1), stem(n,x1), title('x_1[n]'),grid on
subplot(2,2,3), stem(n,real(X1)), hold on, stem(n,imag(X1),'x'), title('X_1[k] con my DFT4'),grid on
subplot(2,2,2), stem(k,x2), title('x_2[n]'),grid on
subplot(2,2,4), stem(k,real(X2)), hold on, stem(k,imag(X2),'x'), title('X_2[k] con DFT8'),grid on

% FENOMENO DI ZERO INTERLEAVING quadruplo
x1 = [1,2,3,4];
x2 = [1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4];
n=[0:length(x1)-1];
k=[0:length(x2)-1];

X1 = my_DFT(x1);
X2 = my_DFT(x2);


figure(4)
subplot(2,2,1), stem(n,x1), title('x_1[n]'),grid on
subplot(2,2,3), stem(n,real(X1)), hold on, stem(n,imag(X1),'x'), title('X_1[k] con my DFT4'),grid on
subplot(2,2,2), stem(k,x2), title('x_2[n]'),grid on
subplot(2,2,4), stem(k,real(X2)), hold on, stem(k,imag(X2),'x'), title('X_2[k] con DFT8'),grid on
