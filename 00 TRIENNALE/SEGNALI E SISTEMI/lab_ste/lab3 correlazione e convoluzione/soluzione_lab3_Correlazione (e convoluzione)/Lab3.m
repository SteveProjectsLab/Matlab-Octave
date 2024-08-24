% SEGNALI E SISTEMI
% Laboratorio Matlab del 29/03/2023

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
tau = -15:dtau:15; % Asse dei tau... non e' necessariamente uguale a t


% ***************
% * ESERCIZIO 1 *
% ***************

% x = rect(t);
% y = tri(t);
% p = rect(t-1/2)-rect(t-3/2);

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
% Svolgiamo il caso (iv) come esempio, cambiare i segnali per ottenere gli
% altri casi o vedere soluzione inline sottostante
x = rect(tau);
% chiamo y il risultato
y=0*t;

 for k = 1:length(t)
    y(k) = integrale(x.*rect(t(k)-tau),dtau); %attenzione integrale in dtau
 end
 figure(6), plot(t,real(y)), hold on
 plot(t,imag(y),'r--');  title('$$y(t)$$','Interpreter','latex')
 
 y=0*t;

 for k = 1:length(t)
    y(k) = integrale(x.*tri(t(k)-tau),dtau); %attenzione integrale in dtau
 end
 figure(7), plot(t,real(y)), hold on
 plot(t,imag(y),'r--');  title('$$y(t)$$','Interpreter','latex')

