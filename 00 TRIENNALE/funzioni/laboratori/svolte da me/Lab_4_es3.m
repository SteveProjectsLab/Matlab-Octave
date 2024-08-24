clear
close all
clc

dt = 0.01;      %
t = -10:dt:10;  %vettore dei tempi
df = 0.01;      %
f = -15:df:15;  %vettore delle frequenze

% NB il sistema dato è lineare e tempo invariante

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n\nLAB 4 es 3.1\n\n');
%disegnare modulo e fase della risposta in frequenza H(f)

T = 2;
h = 1/T*rect((t-T/2)/T);    %risposta all'impulso h(t)
% plot(t,h), title('h(t)')
H = myFourier(h,t,f);
figure(1),set(1, 'WindowStyle', 'docked')
plot(f,abs(H)), title('Modulo H(f)')

figure(2),set(2, 'WindowStyle', 'docked')
set(1, 'WindowStyle', 'docked')
plot(f,unwrap(angle(H))), title('Fase H(f)')
%unwrap per la fase

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n\nLAB 4 es 3.2\n\n');
%x(t)= A cos(2 pi f0 t)
%scelgo A =1 per comodità
%calcolare y(t) usando il calcolo diretto mediante convoluzione
%y(t) =(x*h)(t)

f0 = 0.2;%lo cambio manualmente {0.2,0.4,0.6,0.8,1}
% se è a frequenza 1 il segnale è nullo (10^-3 lo considero nullo)
y = zeros(1,length(t));
tau = -15:dt:15;
dtau = dt;
for k = 1:length(t)%convoluzione
    y(k) = integrale(cos(2*pi*f0*tau).*rect((t(k)-tau -T/2)/T)/T, dtau);
end
figure(3)
plot(t,y),set(3, 'WindowStyle', 'docked')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% verificare il TH della risposta in frequenza

%indice della frequenza che contiene f0
findex = find(abs(f-f0)<10^(-6));1:length(t)% l'operatore == potrebbe non funzionare
tindex = find(t==0);%così rimane solo la fase
fprintf('Il modulo di H in %f: %f\n', f0, abs(H(findex)))
fprintf('Il massimo di y(t): %f\n\n', max(y))%ampiezza della sinusoide
fprintf('La fase di H in %f: %f\n', f0, angle(H(findex)))
fprintf('La fase di y(t):  %f\n\n', -acos(y(tindex)/max(y)))  
