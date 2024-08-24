close all
clear all
clc
%-------------------------------------------------------------------------
% dalla risposta allo scalino del sistema incognito
% applico il metodo dei due punti

KA = 5; %valore che raggiunge a regime

A= 1;   %AMPIEZZA DELLO SCALINO

K= KA/A;

Ts= 1/100;  % tempo di campionamento dalle specifiche

% calcolo il valore che l'uscita ha al 9,52% e a 63,2%
y1= 0.0952* KA % 0,4760
y2= 0.632* KA  % 3,16

%guardo (usando lo zoom) a che istanti di tempo corrispondono y1 e y2
% NB tolgo -1 se ho step time a 1, se no avrei dovuto cambiarlo durante la
% simulaizone nelle impostazioni
t1= 3.05 -1;
t2= 8.9 -1;

% so che il sistema di due eq. a due incognite è
        % t1 = 0.1 tau + L
        % t2 = tau + L
% lo risolvo matricialmente

A=[0.1, 1 ; 1, 1 ]; % per i coefficienti
B= [t1 ; t2];

x = inv(A)* B;   %Ricavo tau ed L

%quindi le esplicito:
tau = x(1) %6.5
L =x(2)   %1.4

%sys_c= (K/(tau*s+1))*exp(-L*s);
%-------------------------------------------------------------------------
%Serie ZOH - CAMPIONATORE
% basta ricordasi che ZOH può essere approssimato come un ritardo di Tc/2
% zigler nichlos

Lnew = L+ Ts/2 %1/200 secondi
%-------------------------------------------------------------------------
%ora entrro nella tabella di taratura di Zigler con N=5

N=5;
% definisco i coefficienti del PI e del PID a tempo continuo
Kp_pi= 0.9 * tau/K/Lnew;
Ti_pi= 3 * Lnew;

Kp_pid= 1.2 * tau/K/Lnew;
Ti_pid= 2 * Lnew;
Td_pid= 0.5 * Lnew;

%-------------------------------------------------------------------------
% devo convertirli con tustin a tempo discreto

PI_continuo= tf (Kp_pi,1 ) + tf(Kp_pi, [Ti_pi 0])

PI_discreto= c2d(PI_continuo, Ts, 'tustin')

PID_continuo= tf (Kp_pid,1 ) + tf(Kp_pid, [Ti_pid 0])+ tf([Kp_pid*Td_pid 0], [Td_pid/N 1])

PID_discreto= c2d(PID_continuo, Ts, 'tustin')

%confronto i 2 controllori su SIMULINK

%PI: sovrealongaz. max% = 50% e tempoAssest2%= 27.6 
% (- 1 perchè lo scalino parte da 1)

%PID: sovrealongaz.max% = 40% e tempoAssest2%= 16 
% (- 1 perchè lo scalino parte da 1)

%Quindi il PID garantisce una risposta + veloce e - oscillante

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

%
%Confronto nuovamente le uscite su simulink

%I 2 controllori discretizzati in modo diverso si comportano allo stesso
%modo, con unpicco max dovuto a disturbo pari a 1.7 (da grafico), e 
% una reiezione completa a t= 45.5 secondi
