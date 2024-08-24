clear 
close all
clc

% Come inserire Sistemi
% Come eseguire operazione

num=10; % Definisco numeratore
den1=[1 1]; %Definisco i coefficienti del polinomio s+1
den2=[1/100 1];

%se fosse s^2 + 2, avrei [1 0 2]
%PARTO DAL COEFFICIENTE DEL GRADO MAGGIORE

den= conv(den1, den2); %prodotto tra polinomi ( con * avrei prodotto vettoriale)

%%
%%Modalità 1 di inserimento sistema

sys_c1= tf(num, den); % Crea FUNZIONE TRASFERIMENTO, con denominatore e numeratore
%(Sistema in forma Transfer Function, più facile da trattare)

%%
%%Modalità 2 di inserimento del sistema [esiste solo per s e z]

s=tf('s'); % Richiede in ingresso 1 solo carattere
%È equivalente a s=tf([1 0], 1)
%Mi permette di definire la variabile complessa s
%Come se fosse un sistema G(s)=s

sys_c2= 10/(0.01*s^2 + 1.01*s+1);

%NB: sulle variabili di tipo sistema, posso effettuare operazioni
%algebriche
%(es. sys_c1 + sys_c2)

%PRODOTTO= serie
%SOMMA= parallelo

%%
%Calcolare Zero, Poli, Guadagno

[z,p,k]=zpkdata(sys_c1, 'v'); %Restituisce zeri(z), poli(p)e costante di trasferimento(k)

% 'v': serve a specificare il formato vettoriale in uscita

%ZERI= radici del numeratore: non ci sono in questo caso
%POLI= radici del denominatore: -1 e -100

% Il polo dominante è -1, quello più lento
% Il polo veloce è -100,

%Il sistema è ASINTOTICAMENTE STABILE (Poli reali Negativi)
%[il sistema si comporta come e^(polo), quindi il polo -100 si attenua prima di -1]

Guadagno= dcgain(sys_c1);


%%
%Tracciare Diagramma di Bode

figure(1)
bode(sys_c1) %Traccia il Diagramma di Bode Reale, non asintotico!


%[Con tasto dx su grafico, ho Charateristic, per margini di fase e stabilità]

%NB: dal diagramma vedo la stabilità dell'anello chiuso [con i MARGINI]
%   con i POLI calcolo la stabilità del sistema/ anello aperto

%%
%Calcolare Margine Guadagno e Margine Fase
%NB: Margini di stabilità si riferiscono a sistema in anello chiuso!(= sys_c/(1+sys_c))

[Gm,Pm,Wcg,Wcp] = margin(sys_c1);

%Gm= margine guadagno
%Pm= margine Fase
%Wcg= pulsazione con cui calcolare margine guadagno = sarebbe la pulsazione
%     in cui la fase diventa -180°
%Wcp= pulsazione con cui calcolare margine fase


%%
%DIAGRAMMA di Nyquist, 

figure(2)
nyquist(sys_c1)


%%
%Stabilità del sistema G1: tutti i poli hanno parte reale minore di 0
% -> sistema è asinoticamente stabile

%Margini di fase e di guadagno sono entrambi maggiori di 0 (coerente con sistema asintoticamente stabile in retroazionw)
%MA: i sistema retroazionato ha funz.di trasf.= G1/ 1+G1
%di cui potrebbe non essere semplice calcolare i poli
%Quindi: criterio di bode e di Nyquist:
%per capire stabilità del sistema retroazionato direttamente dal sistema G1
%Ovvero: con margini di fase e di guadagno

%-> PM> 0 e GM>0 -> G1/1+G1 è stabile (sistema retroazionato)

%Quando progettiamo i controllori, metto qualcosa in serie a G1

%NB: stabilità di un sistema in anello aperto di studia:
%   SOLO CON LA PARTE REALE DEI POLI!


%%
%COME INDIVIDUARE GRAFICAMENTE GM E PM

%%
%Margine di fase PM:
%dal digramma di bode del gudagno cerco la pulsazione di taglio
%ovvero pulsazione in cui il grafico taglia l'asse 0 dB
%Guardo la fase corrispondente alla pulsazione di taglio

%PM= fase in puls. taglio - (-180°)
%-> PM>0 <-> wc< 180° (Con wc= pulsazione di taglio)

%Proprietà del sistema retroazionato deducibili da PM:
% se PM > 70/80° : il sistema retroazionato si comporta come un 
%               sistema del 1° ordine 
%MA: sistemi del 1° ordine NON oscillano: 
%per oscillare servono 2 poli compl.coniug. [come FTC]

%NB: evita sistemi con diagrammi di bode del moduloche stanno troppo tempo
%vicino ad asse di 0 dB
%-> le apprssimazioni di basano du fatto che il digramma di Bode del modulo
% del sistema in anello aperto sia:
%>> 1 , per w< wc
%<< 1 , per w> wc

%NB: i sistemi lineari non generano altre pulsazioni oltre a quelle delle
%   sinusoidi usate in ingresso
%    I sistemi NON lineari GENERANO componenti frequenziali


%%
%Margine di Guadagno GM:
% si calcola partendo dalla puulsazione in cui il diagramma di bode della
% fase taglia i 180°, ovvero wπ (pi greco)
%
%Distanza da 0 al valore in wπ è pari a GM:
%:-> GM>0 se diagramma di bode sta sotto o 0

%%
% Oltre al >0 , è importante anche il valore, per capire quanto oscilla

%Inoltre, Margini= perturbazione massima che posso portare al sistema
% mantenendo il sistema stabile

% GM è quanto posso 'sbagliare' il modulo, tenendo il sistema stabile



