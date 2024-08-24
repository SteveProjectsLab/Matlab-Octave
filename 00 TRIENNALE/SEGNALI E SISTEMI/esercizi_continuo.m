clear
close all
clc

dt=0.01;
t=-10:dt:10;
dtau=dt;
tau=-15:dtau:15;
df=0.0001;
f= -15:df:50;
%--------------------------------------------------------------
%%  DISEGNO SEGNALE

%sinint(x)
%x= cos(2*pi*1/2*t+1);
%x=3*sinc((t-1)/2); 

%x=si(t);
%x=rect(t-6).*cos(2*pi*t)+gradino(t-4)+sgn(t);
%x=rect((t-1)/2);
%x=rect(-1/2*t-1);
%x=tri((t-1)/2);
%x=4*tri((t)/2);
x=tri(4*(t-1/4));
%x=sinc(2*t);
%y=sinc(t/2);
%x=gradino(t)-[tri(t)+tri(t-2)+tri(t-4)+tri(t+2)+tri(t+4)]
%x=gradino(rect(t)-1/2);
%x=4*tri(t);
%x=rect(t/4+1)+rect(t/4-1);
%x=tri(t/2)
%x=rect(6*(t-1/3));
fprintf('energia:%.4f\n',myEnergia(x,dt))
%fprintf('potenza:%.4f\n',myPotenzaPeriodico(x,dt,2,t))
figure(1), set(1, 'WindowStyle', 'docked'),
plot(t,x,'b'); grid on;hold on;
%plot(t,y,'r'); grid on;
%axis([min(t) max(t) min(x)-.5 max(x)+.5]);


%--------------------------------------------------------------
fprintf("\npremere un tasto per continuare")
pause; 
clc
close all

%% DISEGNO SEGNALE PERIODICO

% ONDA QUADRA--------------------------------------------------------------           
figure(1)
T=2;
x1=zeros(1, length(t));

for n = floor(min(t)/T): ceil(max(t)/T)  
     x1= x1 + rect((t-n*T));
end
plot(t,x1 , 'black'),grid on, axis([min(t) max(t) -0.2 1.2]);

% ONDA TRIANGOLARE---------------------------------------------------------
figure(2)
T=2;
x1=zeros(1, length(t));

for n = floor(min(t)/T): ceil(max(t)/T)  
     x1= x1 + tri((t-n*T));
end
plot(t,x1 , 'black'),grid on, axis([min(t) max(t) -0.2 1.2]);

% sinc traslati------------------------------------------------------------
for k=0:10
    1/3*(sinc(k/3))

    plot(k,x1 , 'black'),grid on, axis([min(t) max(t) -0.2 1.2]);
end
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

%% prodotto scalare

x= sqrt(2)/2*rect(t/2);
y= tri(t);
fprintf('il prodotto scalare vale:%.4f', myScalarProduct(x,y,dt))

%% correlazione
%x= 3*ones(1,length(t)); y= x;
x=2*rect(t/10);
figure(1);
subplot(2,1,1);
plot(t,x,'r');title("segnali");grid on; hold on;
axis([min(t) max(t) 0 4])
%plot(t,y,'b');grid on; hold on;
hold off;
z1=myCrossCorrelazioneLineare(x,x,t,tau,dt);
%z2=myCrossCorrelazioneLineare(y,x,t,tau,dt);
subplot(2,1,2);
plot(tau,z1,'r');grid on; title("cross correlazione");
axis([min(t) max(t) min(z1)-0.2 max(z1)+0.2])
%plot(tau,z2,'b'); hold on;


%% convoluzione
z = zeros(1, length(t));  % autoConv è definita su t

for k= 1:length(t)
    z(k)=integrale(gradino( tau).*(-tau-2).*(rect( (t(k)-tau+1/2))), dtau);
end


plot(t,z);grid on;
x=rect(t/3);
%c=myConvoluzione(x,x,t);
c=myConvoluzione(myConvoluzione(x,x,t),x,t);

plot(t,c);grid on;
%% TDF
x=6*cos(8*pi*t)+8*sinc(4*t)+2*power(sinc(t),2) 
X=myFourier(x,t,f);
plot(f,X,'b');grid on;
%% TDF modulo e fase
%h=5*rect((t+6)/2);
%H=myFourier(h,t,f);
H=exp(-1i*12*pi*f);
visualizzaModulo_Fase(f,H,'h');


