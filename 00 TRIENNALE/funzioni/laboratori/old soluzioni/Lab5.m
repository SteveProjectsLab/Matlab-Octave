clear 
close all
clc

dt = 0.01;
t = -10:dt:10;
df = 0.01;
f = -15:df:15;

% ES. 1i

x1 = sinc(5*t);
X1 = T_Fourier(x1,t,f);
figure
plot(f,abs(X1),f,angle(X1)), legend('Modulo','Fase')

x2 = sinc(5*(t-1/2));
X2 = T_Fourier(x2,t,f);
figure
plot(f,abs(X2),f,angle(X2)), legend('Modulo','Fase')

x3 = sinc(5*(t+1));
X3 = T_Fourier(x3,t,f);
figure
plot(f,abs(X3),f,angle(X3)), legend('Modulo','Fase')

% ES. 1ii

x4 = sinc(t).^2.*cos(10*pi*t);
X4 = T_Fourier(x4,t,f);
X4_calcolata = 0.5*tri(f-5) + 0.5*tri(f+5);
figure
subplot(1,2,1), plot(f,real(X4)), title('TdF calcolata via matlab'), axis([-10 10 0 1])
subplot(1,2,2), plot(f,real(X4_calcolata)), title('TdF calcolata analiticamente'), axis([-10 10 0 1])

x5 = sinc(t).*cos(10*pi*t).^2;
X5 = T_Fourier(x5,t,f);
X5_calcolata = 0.25*rect(f+10) + 0.5*rect(f) + 0.25*rect(f-10);
figure
subplot(1,2,1), plot(f,real(X5)), title('TdF calcolata via matlab'), axis([-10 10 0 1])
subplot(1,2,2), plot(f,real(X5_calcolata)), title('TdF calcolata analiticamente'), axis([-10 10 0 1])

% Es. 2

B = 2;
h = 2*B*sinc(2*B*t); H = rect(f/(2*B));
h1 = h.*rect(t/4); H1 = T_Fourier(h1,t,f);
h2 = h.*rect(t/10); H2 = T_Fourier(h2,t,f);
h3 = h; H3 = T_Fourier(h3,t,f);

figure
subplot(3,2,1), plot(t,h1), title('h1')
subplot(3,2,2), plot(f,real(H1)), title('H1')
subplot(3,2,3), plot(t,h2), title('h2')
subplot(3,2,4), plot(f,real(H2)), title('H2')
subplot(3,2,5), plot(t,h3), title('h3')
subplot(3,2,6), plot(f,real(H3)), title('H3')

fprintf('Massima sovraelongazione di H1 = %f\n', max(real(H1)))
fprintf('Massima sovraelongazione di H2 = %f\n', max(real(H2)))
fprintf('Massima sovraelongazione di H3 = %f\n', max(real(H3)))

fprintf('Energia della differenza tra H e H1 = %f\n', integrale(abs(H-H1).^2, df))
fprintf('Energia della differenza tra H e H2 = %f\n', integrale(abs(H-H2).^2, df))
fprintf('Energia della differenza tra H e H3 = %f\n', integrale(abs(H-H3).^2, df))

% Es. 3

R = 3300;
C = 1/1000;
ft = 1/(2*pi*R*C); % Occhio, aggiungere 2pi
H = 1./(1+1j*2*pi*f*R*C);

% i

figure
subplot(2,1,1), plot(f,abs(H)), title('Modulo di H')
subplot(2,1,2), plot(f,angle(H)), title('Fase di H')

% ii
flog = ft/100:df:ft*100;
Hlog = 1./(1+1j*2*pi*flog*R*C);

figure
subplot(2,1,1), loglog(flog,abs(Hlog)), title('Modulo di H'), grid on
subplot(2,1,2), semilogx(flog,angle(Hlog)), title('Fase di H'), grid on

% iii
tau = t;
dtau = dt;
h = Inv_T_Fourier(H,f,tau);
y = zeros(1,length(t));
for k = 1:length(t)
    y(k) = integrale(h.*gradino(-tau+t(k)), dtau);
end
figure
plot(t,abs(h)), title('h')
figure
plot(t,abs(y)), title('y')
