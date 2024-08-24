clear
close all
clc

dt=0.01;
t=-10:dt:10;

dtau=dt;
tau=-15:dtau:15;

df=0.01;
f= -15:df:15;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       PROBLEMA 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Problema 1\n\n');

x = tri(t);
h1 = sinc(4*t);
h2 = sinc(4*t).^2;

% figure(1),set(1, 'WindowStyle', 'docked')
% plot(t,x),title('x'),axis([min(t) max(t) -.25 2]),grid on;
% figure(2),set(2, 'WindowStyle', 'docked')
% plot(t,h1),title('h1'),axis([min(t) max(t) -.5 1.5]),grid on;
% figure(3),set(3, 'WindowStyle', 'docked')
% plot(t,h2),title('h2'),axis([min(t) max(t) -2 2]),grid on;

%eseguo la convoluzione di x con h1
xtau=tri(tau);
conv=zeros(1,length(tau));
 for k = 1:length(t)
    h=sinc((t(k)-tau-4));%
    conv(k) = myIntegrale(xtau.*h,dtau);
 end
 
%eseguo la convoluzione del precedente risultato con h2
conv1=zeros(1,length(t));
 for k = 1:length(t)
    h=sinc((t(k)-tau-4)).^2;%
    conv1(k) = myIntegrale(conv.*h,dtau);
 end
% ho così ottenuto y(t)

X=myFourier(x,t,f);
figure(1),set(1, 'WindowStyle', 'docked')
subplot(3,2,1), plot(t,x),title('x'),axis([min(t) max(t) -.25 2]),grid on;
subplot(3,2,2),plot(f,abs(X)),title('modulo');
subplot(3,2,3),%stampare h(t)
subplot(3,2,4),%stampare fase H
subplot(3,2,5),plot(t,conv1),title('y(t)');
subplot(3,2,6), 
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       PROBLEMA 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   campionare il segnale
fprintf('Problema 2\n\n');
T = 5;
% rendo il segnale x periodico di periodo T=5
xp=zeros(1,length(t));
for n = floor(min(t)/T): ceil(max(t)/T)  
    xp= xp + tri(t-n*T);
end
%X = myFourier(xp,t,f); %calcolo la TDF

origine = ceil(length(t)/2);
xc=zeros(1,length(t));
for n = 0:1:50 %va da 10 con passo 1 fino a 
    Tc = n*dt; %tempo di campionamento
    tsample = mod(origine,n):n:length(t);% indice dei campioni che voglio campionare
    xc = zeros(1,length(t));% inizializzo il vettore di zeri
   % xc(tsample) = xp(tsample);%tutti zeri tranne in cui il segnale è uguale al segnale originale
end

%xp_calc = myFourierInv(xc,f,t);

%figure(4),set(4, 'WindowStyle', 'docked')
%plot(t,xp),title('xp'),axis([min(t) max(t) -.25 1.5]),grid on;
figure(2),set(2, 'WindowStyle', 'docked');
subplot(1,2,1),plot(t,xp),title('segnale xp periodico'),axis([min(t) max(t) -.25 1.5]),grid on;
subplot(1,2,2),plot(t,xc),title('segnale calcolato mediante antitrasformata');
%segnale mediante ricostruzione ( non richiesto dal testo, ma facevo così)
%campiona(xp,10,10,10,t,f,1,111); %nota 1 ideale, 2 mantenitore, 3 lineare %111 numero figura elevato

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       PROBLEMA 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Problema 3\n\n');

    bit = 3; % numero di bit utilizzati
    xq = myQuant(x,bit); % quantizzo il segnale
    errq = x-xq; 
    
    figure(3),set(3, 'WindowStyle', 'docked')
    plot(t,x,t,xq,t,errq),title('Problema 3'),legend('x','xq','errore'),...
        axis([-3 3 -.25 1.25]),grid on;
    
    fprintf('Potenza media dell''errore di quantizzazione con %d bits: %f\n', bit, ...
        myIntegrale(errq.^2,dt)/(t(end)-t(1)))


%%

%       QUESITO 1
fprintf('Quesito 1\n\n');

s1=tri(t-4);
fprintf('integrale di tri(t-4)= %.2f ',myIntegrale(s1,dt));
fprintf('\n punto medio di tri(t-4)= %.2f ',puntomedio(s1,dt));
%%

%       QUESITO 2
fprintf('Quesito 3\n\n');
%%

%       QUESITO 3
fprintf('Quesito 3\n\n');