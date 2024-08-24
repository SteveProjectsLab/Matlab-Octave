%-------------------------------------------------------------------------
%-------------------------------------------------------------------------
% pulisco il worksspace, chiudo tutte le finestre, pulisco la console
clear
close all
clc

% inizializzo l'asse dei tempi
dt=0.01;
t=-10:dt:10;

dtau=dt;
tau=-15:dtau:15;

% inizializzo l'asse delle frequenze
df=0.01;
f= -15:df:15;
%-------------------------------------------------------------------------
fprintf('\nProblema - Punto 1\n\n');
%-------------------------------------------------------------------------

% calcolo per via diretta
x=tri(t);
h1=sinc(4*t);
h2=sinc(4*t).^2;
h=myConvoluzione(h1,h2,t);
y=myConvoluzione(x,h,t);

% calcolo tramite le proprietà di convoluzione
X=myFourier(x,t,f);
H=myFourier(h,t,f);
Y=X.*H;
y1=myFourierInv(Y,f,t);

figure(1), title('Problema 1'),set(1, 'WindowStyle', 'docked');

subplot(2,3,1); plot(t,x); title('x(t)'); grid on;
subplot(2,3,2); plot(t,h); title('h(t)');  grid on;
subplot(2,3,3); plot(t,y);title('y(t)'); grid on;

subplot(2,3,4); plot(abs(X));title('|X(f)|'); grid on;
subplot(2,3,5); plot(abs(H));title('|H(f)|'); grid on;
subplot(2,3,6); plot(y1);title('y(t)=invF{X(f)H(f)}|'); grid on;

% y ottenuta attraverso le proprietà di fourier non è come mi sarei
% aspettato

fprintf("\npremere un tasto per continuare\n")
pause; 
clc
close all
%
%-------------------------------------------------------------------------
fprintf('\nProblema - Punto 2\n\n');
%-------------------------------------------------------------------------
% Fundamental period
T = 5;

% xp = zeros(size(t));
% for n = floor(min(t)/T):ceil(max(t)/T)
%     xp = xp + tri(t/T-n);
% end

% ho avuto problemi qui e ho deciso di fare i quesiti 1 e 2 

xp=tri(t+2*T)+tri(t+T)+tri(t)+tri(t-T)+tri(t-2*T);
plot(t,xp);

% poi per questioni di tempo non sono riusciot a finire
% avrei usato le funzioni presenti nella cartella, "myQuant" e "campiona"

%-------------------------------------------------------------------------
fprintf('\nProblema - Punto 3\n\n');
%-------------------------------------------------------------------------




