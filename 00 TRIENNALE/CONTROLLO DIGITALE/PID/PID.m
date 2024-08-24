% controllore PID

% c'è un sistema incognito da controllare
% simulo la sua risposta al gradino

% sposto lo step time a 0

% osservo che il sistema va a regime a circa 50 secondi

% utilizzo il METODO DEI DUE PUNTI
% per ricavare la costante di tempo diomninante ed approssimarlo così
% come un sistema del rpimo ordine

Ts=1/100
% calcolo il valore dell'uscita al 9,52% e al 63,2%
KA=5    % valore che raggiunge a regime
A=1     % ampiezza dello scalino
k=KA/A  % guadagno

y1=0.0952*KA    % 0.4760
y2=0.632*KA     % 3.1600

% guardo dallo scope dell'uscita quando raggiunge i due valore y1 e y2

t1= 2.05
t2= 7.9

% il sistema di due equazioni e due incognite è
% t1= 0.1 tau + L
% t2= tau +L
% lo riscrivo matricialmente
A=[0.1,1;1,1]
B=[t1 ;t2]
x=inv(A)*B
tau = x(1)      % 6.5
L=x(2)          % 1.4

%sys=(k/(tau*s+1))*exp(-L*s)


% zoh approssimato come un campionatore
    Lnew= L+Ts/2

% entro nella tabella di zigle nichlos

    N=5
% progetto PI
    Kp_pi =0.9*tau/k/Lnew;
    Ti_pi =3*Lnew;

    PI_continuo= tf(Kp_pi,1)+tf(Kp_pi, [Ti_pi 0]);
    PI_d= c2d (PI_continuo, Ts, 'tustin')

% progetto PID
    Kp_pid =1.2*tau/k/Lnew;
    Ti_pid =2*Lnew;
    Td_pid =0.5*Lnew;

    PID_continuo=tf(Kp_pid,1)+tf(Kp_pid, [Ti_pid 0])+tf([Kp_pid*Ti_pid 0],[Td_pid/N 1])
    PID_d=c2d (PID_continuo, Ts,'tustin')