clear
close all
clc
grid on;

dt=0.01;
t=-10:dt:10;

%esercizio 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%disegnare nella stessa finestra i segnali

x1=4*rect((t-3)/10);
x2=3*tri((t+1)/4);
x3=gradino(-t+2);
figure(1), set(1, 'WindowStyle', 'docked'),plot(t,x1,t,x2,t,x3),title('parte 1 '),legend('x1','x2','x3'),grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%disegnare nella stessa finestra i segnali

x4=x1+2*x2+3*x3;
x5=x1.*x2.*x3;
figure(2), set(2, 'WindowStyle', 'docked'),plot(t,x4,t,x5),title('parte 2 '),legend('x4','x5'),grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%disegnare i segnali

x6=sin(t);
x7=cos(2*pi*t);
x8=x6.*x7;
x9=x6+x7;

figure(3), set(3, 'WindowStyle', 'docked'),plot(t,x6,t,x7),title('parte 3 '),legend('x6','x7')
figure(4), set(4, 'WindowStyle', 'docked'),plot(t,x8),title('x8'),grid on
figure(5), set(5, 'WindowStyle', 'docked'),plot(t,x9),title('x9'),grid on
grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%esercizio 2
%determinare la forma analitica dalle figure usando i segnali elementari

u=tri(t)+rect(1/2*t);
v=3*sin((0.5*pi)*t-pi/2);
y = 2*sin(pi*t).*rect((t+3)/6)+4*tri((t-4)/4)-3*tri((t-4)/3);

figure(6), set(6, 'WindowStyle', 'docked');
plot(t,u,t,v,t,y),axis([-10 10 -5 5]),grid on
