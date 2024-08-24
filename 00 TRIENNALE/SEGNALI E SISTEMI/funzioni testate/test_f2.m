clear
close all
clc

dt=0.01;
t=-10:dt:10;

dtau=dt;
tau=-15:dtau:15;

df=0.01;
f= -15:df:15;
fprintf('TEST FUNZIONI parte 2\n\n');
%%
clc;close all
%   TRASFORMATA E ANTITRASFORMATA DI FOURIER
x1=rect(t);
r=1;%righe
c=4;%colonne

X1=myFourier(x1,t,f);
Xanti=myFourierInv(X1,f,t);

figure
subplot(r,c,1),plot(t,x1),title('segnale: rect(t)'),axis([min(t) max(t) min(gradino(t))-.25 max(gradino(t))+.25]),grid on
subplot(r,c,2),plot(f,real(X1)),title('trasformata real'),axis([min(t) max(t) min(gradino(t))-.25 max(gradino(t))+.25]),grid on
subplot(r,c,3),plot(f,imag(X1)),title('trasformata imag'),axis([min(t) max(t) min(gradino(t))-.25 max(gradino(t))+.25]),grid on
subplot(r,c,4),plot(t,real(Xanti)),title('antitrasformata'),axis([min(t) max(t) min(gradino(t))-.25 max(gradino(t))+.25]),grid on

%%
clc;close all
%   SERIE DI FOURIER (esempio REALE
T=4;
x1=zeros(1, length(t));
%Come rappresentare un segnale periodico
for n = floor(min(t)/T): ceil(max(t)/T)  
     x1= x1 + rect((t-n*T));
end
figure(1),set(1, 'WindowStyle', 'docked')
plot(t,x1),axis([-4 4 -.25 2]),grid on
N_Armoniche_Vettore= [5 10 50 100];

x1_approssimato_calc= zeros(length(N_Armoniche_Vettore), length(t));

for n= 1: length(N_Armoniche_Vettore)
   
    N_Arm=N_Armoniche_Vettore(n);
    x1_approssimato_calc=SDF_REALE(x1,N_Arm, length(N_Armoniche_Vettore), T, t, dt);
    
    figure(n+1),set(n+1, 'WindowStyle', 'docked')
    subplot(3,1,1), stampa_ak(calcolo_ak(x1, N_Arm, T, t, dt), N_Arm)
    subplot(3,1,2), stampa_bk(calcolo_bk(x1, N_Arm, T, t, dt), N_Arm)
    subplot(3,1,3), plot(t, x1_approssimato_calc(n,:), t, x1), title (sprintf('x1 ricostruito con b calcolato con l''integrale con %d armoniche', N_Arm))
    
end


%%
clc;close all
%   VERIFICA DELLA RISPOSTA IN FREQUENZA

T = 2;
h = 1/T*rect((t-T/2)/T);    %risposta all'impulso h(t)
H = myFourier(h,t,f);

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


%%

%   CAMPIONAMENTO
clc;close all
%x=cos(t);
%x=sin(t);
%x= 4*exp(-10*t.^2);%gaussiana
%x = 8*sinc(t/2); % Cambiare il segnale a seconda dell'esercizio

y=rect(t);
z=tri(t);
figure(1);
plot(t,y),set(1, 'WindowStyle', 'docked')
figure(2);
plot(t,z),set(2, 'WindowStyle', 'docked')

campiona(x,10,10,50,t,f,2,1);%nota 1 ideale, 2 mantenitore, 3 lineare






