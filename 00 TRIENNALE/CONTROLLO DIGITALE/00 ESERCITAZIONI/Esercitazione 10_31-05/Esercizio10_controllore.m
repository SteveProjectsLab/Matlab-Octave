%% Analisi sistema controllore

Tc=0.001;

num= [10 1];

den= conv([100 1], [ 0.1 1]);

%% Controllo per discretizzazione

% 1) aggiungo ZOH e campionatore

 Gzoh= tf( 1, [0.5*Tc 1]);
 
 % 2)Definisco il sottosistema Analogico
 
 Ga= G*Gzoh; 
 
 %% Specifiche
 
 % 1) Errore a regime nullo
 
%  -> Metto integratore su Gcl= C*G.
%  
%  Poichè G non ce l'ha, lo metto su C.


 % 2) Sistema Gcl con comportamento simile al 1° ordine, con Tempo arrivo a regime = 1s
 
%  -> PM> 75° e T= 5*costante di tempo dominante
%  
%  -> Polo dominante= -1/costante di tempo dominante
%  
%  -> w_taglio= pulsazione del polo dominante => valore assoluto del polo.
%  
%  
% Risulta PM > 75° e w_taglio > 5


 % 3) Disturbo in retroazione attenuato di 30 dB in w=100
 
%  -> Faccio sì che in w=100 |L|< -30 dB




%% Richieste su Tc

% So che Tc deve rispettare quei 4 vincoli sul Tcampionamento.




 