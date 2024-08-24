% SEGNALI E SISTEMI
% Laboratorio Matlab del 19/04/2021

% Initialization
% Clear the workspace
clear
% Close all the windows
close all

% Temporal axis
dt = 0.01;
t = -10:dt:10;

% Frequency axis
df = 0.01;
f = -15:df:15;


% ***************
% * ESERCIZIO 2 *
% ***************

% Punto 2.i

x1 = rect(t);
X1 = T_Fourier(x1,t,f);
inv_x1 = Inv_T_Fourier(X1,f,t);

x2 = tri(t);
X2 = T_Fourier(x2,t,f);
inv_x2 = Inv_T_Fourier(X2,f,t);

x3 = exp(-pi*t.^2);
X3 = T_Fourier(x3,t,f);
inv_x3 = Inv_T_Fourier(X3,f,t);

figure;
subplot(3,3,1); plot(t,x1); title('$$x_1(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,2); plot(f,real(X1)); title('$$X_1(f)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,3); plot(t,real(inv_x1)); title('$$\hat{x}_1(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,4); plot(t,x2); title('$$x_2(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,5); plot(f,real(X2)); title('$$X_2(f)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,6); plot(t,real(inv_x2)); title('$$\hat{x}_2(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,7); plot(t,x3); title('$$x_3(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,8); plot(f,real(X3)); title('$$X_3(f)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,9); plot(t,real(inv_x3)); title('$$\hat{x}_3(t)$$','Interpreter','latex','FontSize',15); grid on;

% Punto 2.ii

x4 = cos(4*pi*t);
X4 = T_Fourier(x4,t,f);
inv_x4 = Inv_T_Fourier(X4,f,t);
figure;
subplot(3,1,1); plot(t,x4); title('$$x_4(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(f,real(X4)); title('$$X_4(f)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(t,real(inv_x4)); title('$$\hat{x}_4(t)$$','Interpreter','latex','FontSize',15); grid on; axis([-10 10 -1 1])


% ***************
% * ESERCIZIO 3 *
% ***************

% close all;

T = 2;
h = rect((t-T/2)/T)/T;
dtau = 0.01;
tau = -21:dt:21;


H = T_Fourier(h,t,f);
figure; plot(f,abs(H),'b'); title('$\vert H_1(f)\vert$','Interpreter','latex','FontSize',15); grid on;
figure; plot(f,unwrap(angle(H)),'r'); title('$<H_1(f)$','Interpreter','latex','FontSize',15); grid on;
% <H(f): phase jumps in the transform of rect (when sinc changes sign)
% + linear component due to the delay (negative slope because t0>0)

fvet = .2:.2:1; % sine fundamental frequency vector

% Beware of the initial transients!
x = zeros(length(fvet),length(t));
y = zeros(length(fvet),length(t));
for n = 1:length(fvet)
    for k = 1:length(t)
        y(n,k) = integrale(cos(2*pi*fvet(n)*tau).*rect((t(k)-tau-T/2)/T)/T,dtau);
    end
    figure(4+n);
    
    plot(t,y(n,:));
    axis([min(t),max(t),-2,2]);
    findex = find(abs(f-fvet(n))<10^(-6));
    tindex = find(t==0);
    
    title(sprintf('$$y_%d(t)$$',n),'Interpreter','latex','FontSize',15); grid on;
    
    fprintf('|H(f_%d)| = %.2f; infatti max(y_%d(t))=%.2f.\n\n',...
        n,abs(H(findex)),n,max(y(n,:)));
    fprintf('<H(f_%d) = %.2f; infatti la fase di y_%d(t) vale %.2f.\n\n',...
        n,angle(H(findex)),n,-acos(y(n,tindex)/max(y(n,:))));
    % where the abs is zero the phase is not significant... <H(f_5) should
    % be 'wrong'
end

% y(t) for f_5=1 is null because |H(1)|=0; on the other hand, the output
% for that input frequency is, for every time value, just the integral of 
% 2 whole periods of a zero-mean function, so it is always zero.

