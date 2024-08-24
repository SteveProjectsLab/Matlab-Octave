dt=0.01;
t=-10:dt:10;
addpath /Users/nicolatrotti/Desktop/MATLAB/SEGNALI/0.FUNZIONI/

% ESERCIZIO 1

x=rect(t);
a=myCrossCorrelation(x,x,t,t,dt);

y=tri(t);
b=myCrossCorrelation(x,y,t,t,dt);

y2=1j*tri(t+1);
c=myCrossCorrelation(x,y2,t,t,dt);

p = rect(t-1/2)-rect(t-3/2);
d=myCrossCorrelation(p,p,t,t,dt);


figure('name','Correlazioni')
subplot(3,2,1); plot(t,a,LineWidth=2,Color='red'); title('Autocorrelazione $$rect(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,2); plot(t,b,LineWidth=2,Color='black'); title('Correlazione $$rect(t) tri(t)$$ reale','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,3); plot(t,abs(c),LineWidth=2,Color='blue'); title('Modulo correlazione $$rect(t) jtri(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,4); plot(t,angle(c),LineWidth=2,Color='green'); title('Fase correlazione $$rect(t) jtri(t)$$','Interpreter','latex','FontSize',15); grid on;
% subplot(3,2,5); plot(f,d,LineWidth=2,Color='cyan'); title('Autocorrelazione differenza di due $$rect(t)$$','Interpreter','latex','FontSize',15); grid on;
pause

% ESERCIZIO 2

k=-10:1:10;

x=zeros(1,length(t));
for i=k
    x = x + myTranslation(p,-2*i,t,dt);
end

y=sin(pi*t);
e=(myCrossCorrelation(x,y,t,t,dt))/(t(end)-t(1));

figure('name','Correlazioni')
subplot(3,1,1); plot(t,x,LineWidth=2,Color='red'); title('$$rect(t)$$ periodici','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(t,y,LineWidth=2,Color='black'); title('$$sin(pi*t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(t,e,LineWidth=2,Color='blue'); title('Correlazione $$rect(t)$$ periodico $$sin(pi*t)$$','Interpreter','latex','FontSize',15); grid on;
pause 

f=(myCrossCorrelation(x,x,t,t,dt))/(t(end)-t(1));
figure('name','Autocorrelazione rect periodico')
plot(t,f,LineWidth=2,Color='red'); title('Autocorrelazione $$rect(t)$$ periodici','Interpreter','latex','FontSize',15); grid on;
pause

% ESERCIZIO 3

x=rect(t);
h=rect(t);
f=myConvolution(x,h,t);

x=rect(t);
h=tri(t);
g=myConvolution(x,h,t);

x=rect(t);
h=1j*tri(t+1);
i=myConvolution(x,h,t);

x=rect(t-2);
h=exp(-t).*gradino(t);
k=myConvolution(x,h,t);

x=rect(t/2);
h=sinc(5*t);
l=myConvolution(x,h,t);

figure('name','Convoluzioni')
subplot(3,2,1); plot(t,f,LineWidth=2,Color='red'); title('Convoluzione $$rect(t) rect(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,2); plot(t,g,LineWidth=2,Color='black'); title('Convoluzione $$rect(t)$$ $$tri(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,3); plot(t,abs(i),LineWidth=2,Color='blue'); title('Modulo convoluzione $$rect(t)$$ $$jtri(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,4); plot(t,angle(i),LineWidth=2,Color='green'); title('Fase convoluzione $$rect(t)$$ $$jtri(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,5); plot(t,k,LineWidth=2,Color='cyan'); title('Convoluzione $$rect(t)$$ $$exp(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,2,6); plot(t,l,LineWidth=2,Color='yellow'); title('Convoluzione $$rect(t)$$ $$sin(pi*t)$$','Interpreter','latex','FontSize',15); grid on;