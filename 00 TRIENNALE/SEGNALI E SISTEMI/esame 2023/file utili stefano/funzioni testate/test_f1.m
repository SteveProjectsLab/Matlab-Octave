clear
close all
clc

dt=0.01;
t=-10:dt:10;

dtau=dt;
tau=-15:dtau:15;

df=0.01;
f= -15:df:15;
fprintf('TEST FUNZIONI parte 1\n\n');
%%  

%   SEGNALI NOTI

clc;close all
fprintf('stampo i segnali noti\n\n');
figure(1),set(1, 'WindowStyle', 'docked')
plot(t,rect(t)),title('rect(t)'),axis([min(t) max(t) min(rect(t))-.25 max(rect(t))+.25]),grid on
figure(2),set(2, 'WindowStyle', 'docked')
plot(t,tri(t)),title('tri(t)'),axis([min(t) max(t) min(tri(t))-.25 max(tri(t))+.25]),grid on
figure(3),set(3, 'WindowStyle', 'docked')
plot(t,sgn(t)),title('sgn(t)'),axis([min(t) max(t) min(sgn(t))-.25 max(sgn(t))+.25]),grid on
figure(4),set(4, 'WindowStyle', 'docked')
plot(t,gradino(t)),title('gradino(t)'),axis([min(t) max(t) min(gradino(t))-.25 max(gradino(t))+.25]),grid on

%%

%   INTEGRALE 

clc;close all
integrale=0;
integrale=myIntegrale(rect(t),dt);
fprintf('integrale di rect(t): %.2f\n\n', integrale);
%%

%   ENERGIA, POTENZA-PERIODICO

clc;close all
e1= myEnergia(rect(t),dt);
fprintf('energia rect(t): %.2f\n\n', e1);
s3=sin(2*pi*t/3);
T=3;
p1= myPotenzaPeriodico(s3,dt,T,t);
fprintf('potenza sinusoide: %.2f\n\n', p1);

%%

% NORMA, PRODOTTO SCALARE, DISTANZA, DISTANZA AL QUADRATO, SCHWARZ

clc;close all
x=3*rect(t);
y=tri(t);
%   norma
normx=myNorm(x,dt);
normy=myNorm(y,dt);
fprintf('La norma di x=3.rect(t) vale %.2f\n',normx)
fprintf('La norma di y=tri(t) vale %.2f\n',normy)

%   prodotto scalare
psxy=myScalarProduct(x,y,dt);
fprintf('Il prodotto scalare tra x e y vale %.2f\n',psxy)

%   d2(x,y)
da=myDistance(x,y,dt);
fprintf('la distanza tra x e y vale %.2f\n',da)

%   d2^2(x,y)
db=myDistanzaAlQuadrato(x,y,dt);
fprintf('la distanza^2 tra x e y vale %.2f\n',db)

%   schwarz
mySchwarz(x,y,dt);
%%

% APPROSSIMAZIONE SEGNALE SU BASE

clc;close all
x=sin(t).*abs(t);           %SEGNALE
dim=21;
B=zeros(dim, length(x));    %BASE SU CUI DEVO APPROSSIMARE IL SEGNALE
figure                      %crea un nuovo grafico su cui stamapare la funzione BASE
hold on
for k=1:dim
    B(k,:)= tri( t-k+11);  
end
plot (t, B)
B_ort=myOrtonormalizzazioneGramSchmidt(B, dim, x, dt);
% calcolo l'approssimazione
x_approssimato= approssimazioneSegnaleSuBase(x, B_ort, dim, t);
%%

%   ORTONORMALIZZAZIONE DI GRAM SCHMIDT

clc;close all
dim=21;
B=zeros(dim, length(x));

figure,hold on  %crea un nuovo grafico su cui stamapare la funzione BASE
for k=1:dim
    %B(k,:)= tri( t-k+11);  
    B(k,:)= rect( t-k+11);  
end
plot (t, B)
verificaBaseOrtogonale(B, dim, t)

%ortonormalizzo e verifico
B_ort=myOrtonormalizzazioneGramSchmidt(B, dim, x, dt);
verificaBaseOrtogonale(B_ort, dim, t)
%%

% CORRELAZIONE LINEARE, CIRCOLARE (versione 1)

clc;close all

x = rect(t);
y = tri(t);
p = rect(t-1/2)-rect(t-3/2);

cr_xx=myCrossCorrelazioneLineare(x,x,t,tau,dt);
cr_xy=myCrossCorrelazioneLineare(x,y,t,tau,dt);
cr_pp=myCrossCorrelazioneLineare(p,p,t,tau,dt);

figure(1),set(1, 'WindowStyle', 'docked'), plot(tau,real(cr_xx)), hold on
plot(tau,imag(cr_xx),'r--'), title('cross correlazione xx')
figure(2),set(2, 'WindowStyle', 'docked'), plot(tau,real(cr_xy)), hold on
plot(tau,imag(cr_xy),'r--'), title('cross correlazione xy')
figure(3),set(3, 'WindowStyle', 'docked'), plot(tau,real(cr_pp)), hold on
plot(tau,imag(cr_pp),'r--'), title('cross correlazione pp')

f=(myCrossCorrelation(x,x,t,t,dt))/(t(end)-t(1));
figure('name','Autocorrelazione rect periodico')
plot(t,f,LineWidth=2,Color='red'); title('Autocorrelazione $$rect(t)$$ periodici','Interpreter','latex','FontSize',15); grid on;
pause

%%

% CORRELAZIONE LINEARE, CIRCOLARE (versione 2)

clc;close all
%x=rect(t);y=2*rect(t-2)-1;%da esercizio fatto con Guerrini
x=rect(t);y=2*rect(t-2)-1;
T=2;
z=sin(pi*T);
CorrelazioneXY=zeros(length(tau));
AutoCorrelazione=zeros(length(tau));
CorrelazioneCircolare=zeros(length(tau));


for k=1:length(tau);
    %cross-correlazione
    ytau=2*rect(t+tau(k)-2)-1;
    CorrelazioneXY(k)=myCorrelazioneLin(x,ytau,dt);
    %auto-correlazione
    xtau=rect(t+tau(k));
    AutoCorrelazione(k)=myCorrelazioneLin(x,xtau,dt);
  
end

figure
plot(tau,CorrelazioneXY),title('correlazioneXY'),grid on
figure
plot(tau,AutoCorrelazione),title('auto correlazione rect'),grid on
y=sin(pi*t);
x = rect(t-0.5) - rect(t+0.5);

%calcolare crosscorrelazione circolare e autocorrelazione

CorrelazioneCircXY=zeros(1,length(tau));
xT=x.*rect(t/2);
for k=1:length(tau);
  ytau=sin(pi*(t+k));
  yT=ytau.*rect(t/2);
  CorrelazioneCircXY(1,k)=myCorrelazioneLin(xT,yT,dt)/2;
end
figure
plot(tau,CorrelazioneCircXY);

%%

%	CONVOLUZIONE

%NB far partire la prima sezione manualmente
% esercizio svolto con Guerrini, dovrebbe risultare un trapezio
% x(t) = r rect((t-3)/4)
% y(t) = 1/3 rect ((t+2)/2)
% (x*y)(t) dovrebbe uscire un trapezio 

clc;close all

x=3*rect((tau-3)/4);
conv=zeros(1,length(t));
 for k = 1:length(t)
    h=1/3*rect((t(k)-tau+2)/2);
    conv(k) = myIntegrale(x.*h,dtau);
 end
figure
plot(t,conv),axis([min(t) max(t) min(x)-.25 max(x)+.25]);
