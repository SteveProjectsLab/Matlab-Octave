clear all

% PUNTO 1: per calcolare l'approssimante devo simulare il sistema e poi
% procedere all'approssimazione
KA=5; % abbiamo usato uno scalino di ampiezza A=1 per tracciare l'uscita (A=1)
A=1;
K=KA/A;
Y1=0.0952*KA % t1 è l'istante di tempo in cui l'uscita raggiunge il 9.52% del valore di regime KA
Y2=0.632*KA % t2 è l'istante di tempo in cui l'uscita raggiunge il 63.2% del valore di regime KA
t1=3.05-1; %perché ho fatto la simulazione con lo scalino di default che parte dall'istante t=1
t2=8.9-1;

% a questo non devo fare altro che risolvere il sistema
% t1=0.1tau+L
% t2=tau+L
% nelle incognite tau e L... 
% posso farlo in forma matriciale: definisco x=[tau;L] (vettore colonna)
%                                                              A=[0.1,1;1,1]
%                                                              B=[t1;t2]
% il sistema diventa Ax=B che ha come soluzione x=A^(-1)*B
A=[0.1 1;1 1]
B=[t1;t2]
x=inv(A)*B

% La nostra approssimante del primo ordine più ritardo avrà:
K=5 % (KA=5 e A=1, quindi K=5)
tau=6.5 % (costante di tempo) => più comodo tau=x(1)
L=1.4 % (ritardo) => più comodo L=x(2)
% sys_c=K/(tau*s+1)*exp(-L*s) (sistema del primo ordine più ritardo)

% PUNTO 2: serie ZOH-S-CAMPIONATORE
% In questo caso la serie è "facile", perché basta ricordarsi che lo zoh
% può essere approssimato come un ritardo di Ts/2 (aggiustando già il suo guadagno tenendo conto del campionatore)
% =>un ritardo di 1/200 secondi
% => Gzas=sys_c*exp(-Ts/2 s)=K/(tau*s+1)*exp(-(L+Ts/2)s)

% questa è la approssimante che devo utilizzare quando "entro" nella
% tabella di ziegler-nichols...
% non uso direttamente L, ma una nuova Lnew=L+Ts/2
Ts=1/100;
Lnew=L+Ts/2

% PUNTO 3: definisco i coefficienti del PI e del PID
% ATTENZIONE N=5 (non indicato nel testo per errore)
N=5;
% coefficienti del PI
Kp_pi=0.9*tau/K/Lnew
Ti_pi=3*Lnew

% coefficienti del PID
Kp_pid=1.2*tau/K/Lnew
Ti_pid=2*Lnew
Td_pid=0.5*Lnew

% DISCRETIZZAZIONE DEL PI
% PI=Kp_pi*(1+1/(Ti_pi*s))=Kp_pi+Kp_pi/(Ti_pi*s)
PI_c=tf(Kp_pi,1)+tf(Kp_pi,[Ti_pi 0])
PI_d=c2d(PI_c,Ts,'tustin')

% DISCRETIZZAZIONE DEL PID
% PI=Kp_pid*(1+1/(Ti_pid*s)+Td_pid*s/(Td_pid/N*s+1))=Kp_pid+Kp_pid/(Ti_pid*s)+Kp_pid*Td_pid*s/(Td_pid/N*s+1)
PID_c=tf(Kp_pid,1)+tf(Kp_pid,[Ti_pid 0])+tf([Kp_pid*Td_pid 0],[Td_pid/N 1])
PID_d=c2d(PID_c,Ts,'tustin')

% Dalla simulazione si nota come le due risposte abbiano queste
% caratteristiche:
% PI=>  S%=50% (1.5); Ts2=27.6(-1 perché lo scalino parte da 1)
% PID=>S%=40% (1.4); Ts2=16(-1 perché lo scalino parte da 1)
% => il PID garantisce una risposta con meno sovraelongazione e più veloce
% (proprio perché meno oscillante)

% PUNTO 4: trasf. in avanti per la parte integrale e tustin per le altre...
PID_I_c=tf(Kp_pid,[Ti_pid 0]);
PID_OTH_c=tf(Kp_pid,1)+tf([Kp_pid*Td_pid 0],[Td_pid/N 1]);
PID_OTH_d=c2d(PID_OTH_c,Ts,'tustin'); % tutto tranne l'integrale lo faccio con tustin
% devo discretizzare Kp_pid/(Ti_pid*s) ponendo s=(z-1)/Ts=>
% Kp_pid/(Ti_pid*(z-1)/Ts)=>Kp_pid*Ts/Ti_pid*(z-1)=>facilmente scrivibile a
% tempo discreto
PID_I_d=tf(Kp_pid*Ts,Ti_pid*[1 -1],Ts) % nella funzione tf per i sistemi a tempo discreto specifico il tempo di campionamento
PID2_d=PID_OTH_d+PID_I_d

% PUNTO 5: 
% I due controllori discretizzati in modo diverso si comportano
% praticamente allo stesso modo con un picco massimo dovuto al disturbo
% pari a 1.7 e una reiezione completa al tempo t=45.5s (in 15.5s).