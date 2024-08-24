clear
close all
clc

dt=0.01;
t=-10:dt:10;

dtau=dt;
tau=-15:dtau:15;

df=0.01;
f= -15:df:15;
fprintf('\n\nLAB 4 es 3.1\n\n');
T = 2;
h = 1/T*rect((t-T/2)/T);    %risposta all'impulso h(t)
H = myFourier(h,t,f);
fprintf('\n\nLAB 4 es 3.2\n\n');
f0 = 0.2;
y = zeros(1,length(t));
tau = -15:dt:15;
dtau = dt;
for k = 1:length(t)         %convoluzione
    y(k) = myIntegrale(cos(2*pi*f0*tau).*rect((t(k)-tau -T/2)/T)/T, dtau);
end

% verificare il TH della risposta in frequenza
precisione=10^-6;
myVerificaRispostaInFrequenza(y, H, f,  f0, t,3)
