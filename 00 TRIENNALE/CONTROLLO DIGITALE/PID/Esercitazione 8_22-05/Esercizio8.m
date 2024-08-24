clear 
close all
clc

KA = 5;

A= 1; %AMPIEZZA DELLO SCALINO

K= 5;

Ts= 1/100;

y1= 0.0952* KA ;
y2= 0.632* KA ;


t1= 3.05 -1;
t2= 8.9 -1;

A=[0.1, 1 ; 1, 1 ]; % per i coefficienti
B= [t1 ; t2];

x= inv(A)* B;   %Ricavo tau ed L

%quindi:

tau= 6.5; %(= x(1))
L=1.4;    %(= x(2))

N=5;

%sys_c= (K/(tau*s+1))*exp(-L*s);

%%
%Serie ZOH - CAMPIONATORE

Lnew= L+ Ts/2;

%Gzas= (K/(tau*s+1))*exp(-Lnew*s);


%%
%Definisco i coefficienti del PI e del PID:

Kp_pi= 0.9 * tau/K/Lnew;
Ti_pi= 3 * Lnew;

Kp_pid= 1.2 * tau/K/Lnew;
Ti_pid= 2 * Lnew;
Td_pid= 0.5 * Lnew;


%%
%Discretizzazione:
%Li devo convertire con Tustin:

%PI= Kp_pi*(1  +  1/Ti_pi*s);


PI_continuo= tf (Kp_pi,1 ) + tf(Kp_pi, [Ti_pi 0]);

PI_discreto= c2d(PI_continuo, Ts, 'tustin'); 




%PID= Kp_pid*(1  +  1/(Ti_pid*s)  +  Td_pid *s/ (Td_pid/N*s+1));

PID_continuo= tf (Kp_pid,1 ) + tf(Kp_pid, [Ti_pid 0])+ tf([Kp_pid*Td_pid 0], [Td_pid/N 1]);

PID_discreto= c2d(PID_continuo, Ts, 'tustin')

%confronto i 2 controllori su SIMULINK

%PI: sovrealongaz. max% = 50% e tempoAssest2%= 27.6 (- 1 perchè lo scalino parte da 1)

%PID: sovrealongaz.max% = 40% e tempoAssest2%= 16 (- 1 perchè lo scalino parte da 1)


%Quindi il PID garantisce una risposta + veloce e - oscillante


%%

%Punto 4: uso diversa discretizzazione

% - In avanti : per PI
% - Tustin : per le altre

% Definisco 2 PID serparati, uno per parte integrale 
% e uno per la parte proporzionale e derivativa.

PID_integrale_continuo= tf(Kp_pid, [Ti_pid 0]);

PID_altro_continuo= tf (Kp_pid,1 ) + tf([Kp_pid*Td_pid 0], [Td_pid/N 1]);   %%Somma derivativo e proporzionale


PID_altro_discreto= c2d(PID_altro_continuo, Ts, 'tustin');

%Poi: devo discretizzare PID_integrale_continuo:
% pongo s= (z-1)/Ts 
%così discretizzo Kp_pid/(Ti_pid*s)

%Ottengo Kp_pid*Ts/(Ti_pid*(z-1))

PID_integrale_discreto= tf (Kp_pid*Ts, [Ti_pid -Ti_pid] , Ts); %Poichè è discreta, devo specificare il TEMPO DI CAMPIONAMENTO

%Scrivo PID totale

PID2_d=PID_altro_discreto+PID_integrale_discreto


%%
%Confronto nuovamente le uscite su simulink

%I 2 controllori discretizzati in modo diverso si comportano allo stesso
%modo, con unpicco max dovuto a disturbo pari a 1.7 (da grafico), e 
% una reiezione completa a t= 45.5 secondi