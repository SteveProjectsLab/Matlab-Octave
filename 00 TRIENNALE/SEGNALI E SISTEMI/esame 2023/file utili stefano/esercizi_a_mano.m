clear
close all
clc

dt=0.01;
t=-10:dt:10;
dtau=dt;
tau=-15:dtau:15;
df=0.01;
f= -15:df:15;
%--------------------------------------------------------------
%%
%sinint(x)
%x=3*sinc((t-1)/2); 
%x=si(t);
%x=3*rect((t-5)/2);
%x=tri((t/2-3))
x=tri((t)/2)
%x=sinc(t);
y=sinc(t/2);
fprintf('energia:%.4f',myEnergia(x,dt))

figure(1), set(1, 'WindowStyle', 'docked'),
plot(t,x,'b'); grid on;hold on;
plot(t,y,'r'); grid on;
%axis([min(t) max(t) min(x)-.5 max(x)+.5]);


%--------------------------------------------------------------
fprintf("\npremere un tasto per continuare")
pause; 
clc
close all


%% scomposizione pari e dispari
x=3*rect((t-5)/2);
y=3*rect((-t-5)/2);

figure(1), set(1, 'WindowStyle', 'docked'),
plot(t,x,'b'); grid on;hold on;
plot(t,y,'r');
figure(2), set(2, 'WindowStyle', 'docked'),
plot(t,(x+y)/2,'r'); grid on;hold on;%pari
plot(t,(x-y)/2,'b'); grid on;hold on;%dispari
plot(t,(x+y)/2+(x-y)/2,'g')

%%  energia segnale composto
x=1*((t<=0)&(t>-2))+(-2*exp(-5*t)).*(t>0);
fprintf('energia:%.4f',myEnergia(x,dt))

figure(1), set(1, 'WindowStyle', 'docked'),
plot(t,x,'b'); grid on;