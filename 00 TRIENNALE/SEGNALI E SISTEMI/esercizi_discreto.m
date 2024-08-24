
%%
clear 
close all
clc

N = 16;
n = 0:N-1;
k = 0:N-1;

dt = 0.01;
t = -10:dt:10;

%% disegnare i segnali

% RECT_N
% figure(1)
% x = 1/2*rect_N(n,5);
% stem(n,x); grid on;
% 
% % TRI
% figure(2)
% y = tri(1/4*n);
% stem(n,y)

% COS
figure(3)
z = 3*cos(2*pi*1/3*n);
stem(n,z)
%% convoluzione lineare

%N = 16;
%n = -N:N-1;
%x=(1/2).^n;    % ingresso
%x=rect_N(n-2,4);  
x=[1,1,1,1,1,1,1,1];

%h=(1/4).^n;    % risposta all'impulso
%h=rect_N(n-5,8);      
h=[1,2,2,1];

z=conv(h,x);

subplot(3,1,1), stem([0:length(x)-1],x), title('x[n]'); grid on;
subplot(3,1,2), stem([0:length(h)-1],h), title('h[n]'); grid on;
subplot(3,1,3), stem([0:length(x)+length(h)-2],z), title('z[n]'); grid on;
%% convoluzione indiretta
x=[-2,-1,0,1];
y=[0,1,4];

nx=[0:length(x)-1];
ny=[0:length(y)-1];
nxy=[0:length(x)+length(y)-2]

z=ConvInd(x,y);

subplot(3,1,1), stem(nx,x), title('x[n]'); grid on; hold on, stem(nx,real(x)), hold on; stem(nx,imag(x),'x'); 
subplot(3,1,2), stem(ny,y), title('h[n]'); grid on; hold on, stem(ny,real(y)), hold on; stem(ny,imag(y),'x');  
subplot(3,1,3), stem(nxy,z), title('z[n]'); grid on; hold on, stem(nxy,real(z)), hold on; stem(nxy,imag(z),'x');  
%% convoluzione circolare


%% calcolo DFT

%NB settare N!
%x1 = [3,-3/2,-3/2,3,-3/2,-3/2];    % TE luglio 2023
%x1 = [3,0,-3/2,0,-3/2,0];
x1=exp(-1i*2*pi*3/16*n)+2*cos(pi*1/2*n);
%x1=[-2,-1,0,1,0,0]
X1 = my_DFT(x1);

figure
subplot(2,1,1), stem(n,x1), title('x_1[n]'); grid on;
subplot(2,1,2), stem(n,real(X1)), hold on, stem(n,imag(X1),'x'), title('X_1[k] con my DFT'); grid on;

%% calcolo IDFT


X1 = [4,0,0,2+2*i,4,2-2*i,0,0];

x1=my_IDFT(X1);
figure
subplot(2,1,1), stem(n,real(X1)), hold on, stem(n,imag(X1),'x'), title('X_1[k] con my DFT'); grid on;
subplot(2,1,2), stem(n,real(x1)), hold on, stem(n,imag(x1),'x'), title('X_1[k] con my DFT'); grid on;

%% effetto interpolazione
N = 4;
n = 0:N-1;

x1= [4,5,6,0];
%x1 = [0,0,1,0,2,0,1,0]

X1 = my_DFT(x1);

% interpolo di un fattore 4, diventa dft 12
K= 16;
k = 0:K-1;

x2= [4,0,0,0,5,0,0,0,6,0,0,0,0,0,0,0];
X2 = my_DFT(x2);
figure(1)
subplot(2,1,1), stem(n,x1), title('x_1[n]'); grid on;
subplot(2,1,2), stem(n,real(X1)), hold on, stem(n,imag(X1),'x'), title('X_1[k] con my DFT'); grid on;
figure(2)
subplot(2,1,1), stem(k,x2), title('x_1[n]'); grid on;
subplot(2,1,2), stem(k,real(X2)), hold on, stem(k,imag(X2),'x'), title('X_1[k] con my DFT'); grid on;

%% calcolo IDFT ok

%NB settare N!
X2 = [6,3/2-1i*sqrt(3)/2,3/2+1i*sqrt(3)/2];
x2=my_IDFT(X2);
subplot(2,1,1), stem(n,X2), title('X_1[n]')
subplot(2,1,2), stem(n,abs(x2)), hold on, stem(n,imag(x2),'x'), title('x[n] con my IDFT')




%%
h=[-2,-2,1,2,-1,-2,3,-2,1];
h0=[-2,-2,1,2,-1,-2,3,-2,1];
h1=[0,-2,-2,1,2,-1,-2,3,-2];
hm1=[-2,1,2,-1,-2,3,-2,1,0];

sum(h.*hm1)

