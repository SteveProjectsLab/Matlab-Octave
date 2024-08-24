CONTROLORE PID

Viene dato un tempo di campionamento Ts= 1/100;

Uso METODO DEI 2 PUNTI per realizzare 

posso farlo perchè ho:

- schema simulink

Devo vedere la risposta allo scalino e i valori al:

- 63.2%
- 9.52%

Apriamo simulink e lo schema, metto in ingresso lo scalino e guardo l'uscita.

Se NON VA A REGIME -> aumento il tempo di simulazione

SO:

- K*A= 5;

- A= 1; //AMPPIEZZA DELLO SCALINO

Quindi K=5.

Calcolo i 2 punti con le percentuali:

- y1= 0.0952* K*A  //è il 9.52% del valore di regime

- y2= 0.632* K*A   //è il 6.32% del valore di regime

Graficamente trovo i valori t1 e t2 corrispondenti a y1 e y2:

ZOOMO sul grafico e guardo circa al valore di t corrispondente:

t1= 3.05;

t2= 8.9;

POI : io ho usato lo scalino che partiva da 1 e non da 0!
Quindi, i tempi trovati risultano traslati di 1
TOLGO 1, per sistemare:

t1= 3.05 -1;

t2= 8.9 -1;

ORA DEVO RISOLVERE UN SISTEMA per trovare TAU ed L
Definisco un vettore x= [tau, L].

POI: la matrice A=[0.1, 1 ; 1, 1 ] per i coefficienti
   : il vettore B= [t1 ; t2]
   
Posso scrivere il sistema con:

Ax=B  -->  x= A^(-1) *B


L'approssimante del 1° ordine avrà:

- K=5;
- tau= 6.5; (= x(1))
- L=1.4;    (= x(2))

Creo il sistema:

sys_c= [K/(tau*s+1)]*exp(-L*s)


%
Serie ZOH - CAMPIONATORE

So che ZOH può essere approssimato con un 
ritardo di Ts/2, quindi un ritardo di 1/200.

Gzas= [K/(tau*s+1)]*exp(-(L+ Ts/2)*s);

Quindi si crea una nuova L:

Lnew= L+ Ts/2;

Poi devo guardare la tabella di taratura, con N= 5
Così ricavo i coefficieni del PI:

- Kp_pi= 0.9 * tau/K/Lnew;

- Ti_pi= 3 * Lnew;


I coefficienti del PID:

- Kp_pid= 1.2 * tau/K/Lnew;

- Ti_pid= 2 * Lnew;

- Td_pid= 0.5 * Lnew;

%
DISCRETIZZAZIONE:
MA questi sono i coefficienti a t_continuo

Li devo convertire con Tustin:

PI= Kp_pi*(1  +  1/Ti_pi*s);


PI_continuo= tf (Kp_pi,1 ) + tf(Kp_pi, [Ti_pi 0]);

PI_discreto= c2d(PI_continuo, Ts, 'tustin'); 