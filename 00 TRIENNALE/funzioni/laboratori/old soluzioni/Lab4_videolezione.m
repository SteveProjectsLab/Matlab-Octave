clear
close all
clc

dt = 0.01;
t = -10:dt:10;
df = 0.01;
f = -15:df:15;

% Es.2i

% x1 = rect(t);
% X1 = T_Fourier(x1,t,f);
% plot(f,real(X1)), title('X1')
% x1_inv = Inv_T_Fourier(X1,f,t);
% figure
% plot(t,real(x1_inv)), title('x1 inversa')
% 
% x2 = tri(t);
% X2 = T_Fourier(x2,t,f);
% figure, plot(f,real(X2)), title('X2')
% x2_inv = Inv_T_Fourier(X2,f,t);
% figure, plot(t,real(x2_inv)), title('x2 inversa')
% 
% x3 = exp(-pi*t.^2);
% X3 = T_Fourier(x3,t,f);
% figure, plot(f,real(X3)), title('X3')
% x3_inv = Inv_T_Fourier(X3,f,t);
% figure, plot(t,real(x3_inv)), title('x3 inversa')

% Es 2.ii
% x4 = cos(4*pi*t);
% plot(t,x4)
% X4 = T_Fourier(x4,t,f);
% figure, plot(f,real(X4))

% Es. 3

T = 2;
h = 1/T*rect((t-T/2)/T);
% plot(t,h), title('h(t)')
H = T_Fourier(h,t,f);
% figure
% plot(f,abs(H)), title('Modulo H(f)')
% figure
% plot(f,unwrap(angle(H))), title('Fase H(f)')

f0 = 1;
y = zeros(1,length(t));
tau = -15:dt:15;
dtau = dt;
for k = 1:length(t)
    y(k) = integrale(cos(2*pi*f0*tau).*rect((t(k)-tau -T/2)/T)/T, dtau);
end
figure
plot(t,y)

findex = find(abs(f-f0)<10^(-6));
tindex = find(t==0);
fprintf('Il modulo di H in %f è uguale a %f\n', f0, abs(H(findex)))
fprintf('Il massimo di y(t) è uguale a %f\n\n', max(y))
fprintf('La fase di H in %f è uguale a %f\n', f0, angle(H(findex)))
fprintf('La fase di y(t) è uguale a %f\n\n', -acos(y(tindex)/max(y)))







