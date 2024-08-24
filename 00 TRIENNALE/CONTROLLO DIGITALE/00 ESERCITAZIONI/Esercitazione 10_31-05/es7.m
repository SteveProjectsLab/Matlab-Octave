clear all

% abbiamo visto (a mano) che la nostra Gcl dovrà avere un guadagno pari a 1
% e una coppia di poli c.c. in 0.6+-0.2j
% Inserisco la funzione di trasferimento 
%tf(1,conv([1 -0.6-0.2j],[1 -0.6+0.2j]))
p1=0.6+0.2j;
p2=0.6-0.2j;
Tc=0.01;
Gcl=tf(1,conv([1 -p1],[1 -p2]),Tc) % è una fdt che ha poli in p1 e p2, ma ha a numeratore 1
guadagno=dcgain(Gcl) % il guadagno di questa funzione di trasferimento è pari a 5
% Ma la Gcl che sto cercando deve avere guadagno pari a 1=> mi basta
% dividere per 5 la mia Gcl
Gcl=1/guadagno*Gcl
guadagno=dcgain(Gcl) % la nuova Gcl avrà guadagno pari a 1=>insegue sp a scalino con errore nullo

% Prima di passare al calcolo del controllore devo verificare che il grado
% relativo di Gcl sia maggiore o uguale al grado relativo di Gzas,
% altrimenti devo "aggiustare" la mia Gcl.
%  Gzas ha grado relativo 2 (polinomio a denominatore di grado 2 e
%  polinomio di grado 0 a numeratore)
% così come la nostra Gcl. Quindi non devo fare null'altro su Gcl
Gzas=tf([1],conv([1 -0.2],[1 -0.1]),Tc);
C1=minreal(1/Gzas*Gcl/(1-Gcl))

% PUNTO 2: CONTROLLO DEADBEAT
z=tf('z',Tc)
Gcl=1/z^2
C2=minreal(1/Gzas*Gcl/(1-Gcl))

% CONTROLLORE C4: Gzas (iniziale) e andamento più simile possibila a un
% sistema t.c. del I ordine con polo dominante in -1
% Definisco il mio sistema a t.c. che rispetta la specifica sulla dinamica
Gcl_c=tf(1,[1 1])
Gcl=c2d(Gcl_c,Tc,'tustin')
guadagno=dcgain(Gcl) % ha guadagno quindi insegue setpoint a scalino
% Gcl ha grado relativo 0, mentre Gzas ha grado relativo 2.
C4=minreal(1/Gzas*Gcl/(1-Gcl)) % in questa versione ha grado del numeratore > grado del denominatore=>non causale
% devo modificare Gcl... aggiungo ritardi finché non ho grado del
% denominatore=grado del numeratore (almeno)
Gcl=1/z^2*Gcl % mi servono due ritardi
C4=minreal(1/Gzas*Gcl/(1-Gcl))