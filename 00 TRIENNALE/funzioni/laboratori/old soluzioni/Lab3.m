% Terza esercitazione di laboratorio

% Initialization
% Clear the workspace
clear
% Close all the windows
close all
clc

% Temporal axis
dt = 0.01;
dtau=dt;
t = -10:dt:10;
tau = -15:dtau:15; % Asse dei tau... non è necessariamente uguale a t


% ***************
% * ESERCIZIO 1 *
% ***************

% x = rect(t);
% y = tri(t);
p = rect(t-1/2)-rect(t-3/2);

crosscorrlinx = zeros(size(tau));
crosscorrlinxy = zeros(size(tau));
crosscorrlinp = zeros(size(tau));

for k = 1:length(tau)
    % using the scalar product - explicit signals
     crosscorrlinx(k) = integrale(rect(t).*rect(t+tau(k)),dt);
     crosscorrlinxy(k) = integrale(rect(t).*tri(t+tau(k)),dt);
     crosscorrlinp(k) = integrale((rect(t-1/2)-rect(t-3/2)).*(rect(t-1/2+tau(k))-rect(t-3/2+tau(k))),dt); 
end
figure(1), plot(tau,real(crosscorrlinx)), hold on
plot(tau,imag(crosscorrlinx),'r--'), title('$$\varphi_{x}(\tau)$$','Interpreter','latex')
figure(2), plot(tau,real(crosscorrlinxy)), hold on
plot(tau,imag(crosscorrlinxy),'r--'), title('$$\varphi_{xy}(\tau)$$','Interpreter','latex')
figure(3), plot(tau,real(crosscorrlinp)), hold on
plot(tau,imag(crosscorrlinp),'r--'), title('$$\varphi_{p}(\tau)$$','Interpreter','latex')


% ***************
% * ESERCIZIO 2 *
% ***************
x = zeros(size(t));
T = 2;
for k = floor(min(t)/T):ceil(max(t)/T)
    x = x+rect(t-1/2-k*T)-rect(t-3/2-k*T);
end

corrcircxy = zeros(size(tau));%inizializzo il vettore
for k = 1:length(tau)
    corrcircxy(k) = 1/T*integrale((conj(x).*rect(t/T)).*(sin(pi*(t+tau(k)))),dt);
    corrcircxy(k)= 1/T*myCorrelazioneLin();
end
figure(4), plot(tau,real(corrcircxy)), hold on
plot(tau,imag(corrcircxy),'r--'), title('$$\varphi_{xy}(\tau)$$','Interpreter','latex')

figure(5);
corrcircxx = zeros(size(tau));
for k = 1:length(tau)
    % Costruisco il segnale traslato x(t+tau) che chiamo x_tau
    % si potrebbe evitare con vari accorgimenti sull'intervallo di
    % integrazione, ma per semplicità  lo calcoliamo su tutto l'asse t
    x_tau = zeros(size(t));
    T = 2;
    for r = floor(min(t+tau(k))/T):ceil(max(t+tau(k))/T)
        x_tau = x_tau+rect(t-1/2-r*T+tau(k))-rect(t-3/2-r*T+tau(k));
    end
    
    corrcircxx(k) = 1/T*integrale((conj(x).*x_tau.*rect(t/T)),dt);
end

figure(5), plot(tau,real(corrcircxx)), hold on
plot(tau,imag(corrcircxx), 'r--'), title('$$\varphi_{x}(\tau)$$','Interpreter','latex')


% ***************
% * ESERCIZIO 3 *
% ***************
% Svolgiamo il caso (iv) come esempio, cambiare i segnali per ottenere gli
% altri casi o vedere soluzione online sottostante
x = rect(tau-2);
% chiamo y il risultato
y=0*t;

 for k = 1:length(t)
    y(k) = integrale(x.*exp(-(t(k)-tau)).*gradino(t(k)-tau),dtau); %attenzione integrale in dtau
 end
 figure(6), plot(t,real(y)), hold on
 plot(t,imag(y),'r--');  title('$$y(t)$$','Interpreter','latex')