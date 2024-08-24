dt=0.01;
df=0.01;
t=-10:dt:10;
f=-15:df:15;
addpath /Users/nicolatrotti/Desktop/MATLAB/SEGNALI/0.FUNZIONI/

T=2;
h=(1/T)*rect((t-T/2/T));

% RISPSOTA IN FREQUENZA
H=trasFourier(h,t,f);

subplot(1,2,1); plot(f,abs(H),LineWidth=2,Color='black'); title('$$|H(f)|$$','Interpreter','latex','FontSize',15); grid on;
subplot(1,2,2); plot(f,angle(H),LineWidth=2,Color='red'); title('$$<H(f)$$','Interpreter','latex','FontSize',15); grid on;
pause


% USCITA DEL SISTEMA LTI CON CONVOLUZIONE
A=3;
f0=0.2:0.2:1;

y=zeros(length(f0),length(t));
x=zeros(length(f0),length(t));

for i=1:length(f0)
    x(i,:)=A*cos(2*pi*f0(i)*t);
    y(i,:)=myConvolution(x(i,:),h,t);
end

figure('name','Uscite del sistema tramite convoluzione con risposta all impulso')
subplot(3,2,1); 
hold on
plot(t,x(1,:),LineWidth=2,Color='red');
plot(t,y(1,:),LineWidth=2,Color='black');
grid on
legend('cos(2*pi*0.2*t)','uscita');
hold off
subplot(3,2,2); 
hold on
plot(t,x(2,:),LineWidth=2,Color='red');
plot(t,y(2,:),LineWidth=2,Color='black');
grid on
legend('cos(2*pi*0.4*t)','uscita');
hold off
subplot(3,2,3); 
hold on
plot(t,x(3,:),LineWidth=2,Color='red');
plot(t,y(3,:),LineWidth=2,Color='black');
grid on
legend('cos(2*pi*0.6*t)','uscita');
hold off
subplot(3,2,4); 
hold on
plot(t,x(4,:),LineWidth=2,Color='red');
plot(t,y(4,:),LineWidth=2,Color='black');
grid on
legend('cos(2*pi*0.8*t)','uscita');
hold off
subplot(3,2,5); 
hold on
plot(t,x(5,:),LineWidth=2,Color='red');
plot(t,y(5,:),LineWidth=2,Color='black');
grid on
legend('cos(2*pi*1*t)','uscita');
hold off

pause

% USCITA DEL SISTEMA LTI CON RISPOSTA IN FREQUENZA

H2=zeros(1,length(f0));
k=zeros(1,length(f0));

% RICERCA DEGLI INDICI DELLE FREQUENZE ASSEGNATE NEL VETTORE DELLE
% FREQUENZE
for i=1:length(f0)
    k(i)=find(abs(f-f0(i))<1e-10);
end
for i=1:length(f0)
    H2(i)=H(k(i));
end

% STAMPA DELLA RISPOSTA IN AMPIEZZA E RISPOSTA DI FASE
fprintf('|H(0.2)| = %f\n',abs(H2(1)));
fprintf('<H(0.2) = %f\n',angle(H2(1)));
fprintf('|H(0.4)| = %f\n',abs(H2(2)));
fprintf('<H(0.4) = %f\n',angle(H2(2)));
fprintf('|H(0.6)| = %f\n',abs(H2(3)));
fprintf('<H(0.6) = %f\n',angle(H2(3)));
fprintf('|H(0.8)| = %f\n',abs(H2(4)));
fprintf('<H(0.8) = %f\n',angle(H2(4)));
fprintf('|H(1)| = %f\n',abs(H2(5)));
fprintf('<H(1) = %f\n',angle(H2(5)));


y2=zeros(length(f0),length(t));
for i=1:length(f0)
    y2(i,:)=A*abs(H2(i))*cos(2*pi*f0(i)*t+angle(H2(i)));
end

figure('name','Uscite del sistema tramite risposta in frequenza')
subplot(3,2,1); 
hold on
plot(t,x(1,:),LineWidth=2,Color='red');
plot(t,y2(1,:),LineWidth=2,Color='black');
grid on
legend('cos(2*pi*0.2*t)','uscita');
hold off
subplot(3,2,2); 
hold on
plot(t,x(2,:),LineWidth=2,Color='red');
plot(t,y2(2,:),LineWidth=2,Color='black');
grid on
legend('cos(2*pi*0.4*t)','uscita');
hold off
subplot(3,2,3); 
hold on
plot(t,x(3,:),LineWidth=2,Color='red');
plot(t,y2(3,:),LineWidth=2,Color='black');
grid on
legend('cos(2*pi*0.6*t)','uscita');
hold off
subplot(3,2,4); 
hold on
plot(t,x(4,:),LineWidth=2,Color='red');
plot(t,y2(4,:),LineWidth=2,Color='black');
grid on
legend('cos(2*pi*0.8*t)','uscita');
hold off
subplot(3,2,5); 
hold on
plot(t,x(5,:),LineWidth=2,Color='red');
plot(t,y2(5,:),LineWidth=2,Color='black');
grid on
legend('cos(2*pi*1*t)','uscita');
hold off


