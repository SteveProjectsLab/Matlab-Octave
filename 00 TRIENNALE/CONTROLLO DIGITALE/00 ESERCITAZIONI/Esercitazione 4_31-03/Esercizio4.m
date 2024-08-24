clear 
close all
clc

% PACCHETTO SISOTOOL
% Utile nel progetto di sistemi

%Realizza un controllore in retroazione tale per cui:
%SPECIFICHE:

%- Errore a t infinto = 0,  con ingresso a scalino

%- Sovraelongazione Max : legata a coefficiente di smorzamento dei poli
%                         complessi coniugati, perchè solo cosiì il sisitema oscilla e puè avere
%                         sovreaelongazioni.
%                         Il coefficiente dice quanto velocemente parte
%                         reale smorza la parte immaginaria.
%-> Relazione che lega coefficiente a sovraelongazione max % [Fornito da grafico]
% Se sovraelongazione = 10% => Coefficiente= 0.6

%- Tempo raggiungimento del valore di regime:
% Se il sistema ha PM > 75°, allora il sistema è approssimabile con un sistema del 1° ordine
% e la pulsazione di taglio induce il primo e unico cambio di pendenza, e
% quindi è il polo dominante.
% Il suo inverso è la costante di tempo dominante , dopo 5 cost di temo
% sono a regime.
% w_taglio = 5/T. = Pulsazione di taglio di L
%
%Se il sistema oscilla, il tempo di assestamento è legato a apulsazione
%naturale w_n e coeff smorz.
%w_n= 4/( coeff.smorz. * T) = approssimazione della pulazione di taglio di L

%Disturdo d su retroazione a w_d attenuato di X dB
% Devo avere in entrambi i casi MODULO <= X

%NB: ha senso dare specifiche nel dominio del tempo

%Poi posso usare 2 funzioni di trasferimneto:

% 1) l'anello di retroazione, con Gcl= L/ 1+L

%ERRORE:
% Quindi Gcl deve avere 2 caratteristiche: stabilità e dopo transitorio
% ampiezza deve essere uguale (=> GUADAGNO =1)

%SMORZAMENTO: guardo la formula

% 2) Solo L (0vvero la serie controllore e sistema)

%ERRORE:
% Dovrà esserci quindi l'integratore.
% Modifico il diagramma di bode finchè non rispetta le specifiche

%SMORZAMENTO: 
%Dovrò avere un margine di fase  PM= 100*coefficiente smorzamento


%%
%CODICE

num= 10;

den= [ 0.1 1.1 1];

sys= tf(num, den);

% Con sisotool(sys)
%
%Ho i diagrammi di bode nel caso in cui ci sia anche il controllore
%Sono i diagrammi di Bode reali.
%Posso spostare i poli direttamente dal grafico

% Più risposta allo scalino del sistema retroazionato 

% Modificando il controllore, vedo immediatamente l'effetto delle modifiche
% Si parte da specifiche a bassa frequenza, e poi si va in
%  ORDINE:
%  1) Specifiche a regime(es. errore)
%  2) Transitorio (Pulsazione di taglio e Margine di fase)
%  3) Alta frequenza ( es. Reiezione dei disturbi)

% Specifiche:
% 1) L(s) con integratore
% 
% 2) L(s) deve avere PM > 100*coeff , con coeff= 0.6
% 
% 3) So che T= 4/ (coeff. * wn) ->Voglio che arrivi con T=1
%  -> wn= 4/(coeff.*T) = 6,67 = wt [= valore minimo]


%Aggiungo Zeri e poli Ad Hoc peravere le richieste desiderate
