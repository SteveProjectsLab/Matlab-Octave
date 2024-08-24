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
x1=3*rect(t);
y1=tri(t);
%   norma
normx1=myNorm(x1,dt);
normy1=myNorm(y1,dt);
fprintf('La norma di x1=3.rect(t) vale %.2f\n',normx1)
fprintf('La norma di y1=tri(t) vale %.2f\n',normy1)
%   prodotto scalare
psx1y1=myScalarProduct(x1,y1,dt);
fprintf('Il prodotto scalare tra x1 e y1 vale %.2f\n',psx1y1)
%   d2(x,y)
da=myDistance(x1,y1,dt);
fprintf('la distanza tra x1 e y1 vale %.2f\n',da)
%   d2^2(x,y)
db=myDistanzaAlQuadrato(x1,y1,dt);
fprintf('la distanza^2 tra x1 e y1 vale %.2f\n',db)
%   schwarz
mySchwarz(x1,y1,dt);
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

% CORRELAZIONE LINEARE, CIRCOLARE

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
