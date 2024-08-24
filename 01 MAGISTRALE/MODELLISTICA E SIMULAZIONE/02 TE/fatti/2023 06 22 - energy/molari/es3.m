% Esercizio 3
% Si vuole determinare il modello di un sistema di fornitura di energia per poter in seguito prevedere a 3 ore
% la fornitura necessaria in funzione della temperatura e dell’umidit`a relativa dell’area a cui il sistema dovr`a
% fornire energia.
% (a) Vi si chiede di progettare il software necessario alla selezione automatica del modello tenendo presente che:
% • Il tempo di campionamento `e di 1 ora.
% • Dati sono contenuti nel file energy.mat (c1: energia; c2: temperatura, c3: umidit`a) e sono TUTTI DATI
% VALIDI.
% • Non si conoscono ritardi apprezzabili tra le variazioni degli ingressi e il loro impatto sull’uscita.
% • Si vuole mantenere un modello che ha al massimo 2 coefficienti per la parte autoregressiva e 2 (a testa,
% sempre massimo) per i due ingressi.
% • L’identificazione dovr`a essere realizzata considerando le prestazioni ad 1 ora, ma la selezione del modello
% migliore andr`a fatta sulla base del FPE sul problema da risolvere (si veda inizio esercizio).
% • Si utilizza l’80% del dataset per l’identificazione e il restante 20% per la validazione
clear
close all
clc

load energy.mat

% uscita: c1
% ingressi c2

lung_data_id=length(energy(:,1))*0.87
y=energy(:,1);
u=energy(:,2:3);
Tc=1;

dati=iddata(y,u,Tc);
dati_id=dati(1:lung_data_id);
dati_val=dati(lung_data_id+1:end);

na_max=2;
nb_max=2;
rit=0;

orizzonte_previsione=3;

cont=0;
for iar=1:na_max
    for iex1=0:nb_max% è un problema di previsione per cui posso accettare di non avere ingressi
        for iex2=0:nb_max
            cont=cont+1;
            na=iar;%[iar iar];
            nb=[iex1 iex2];
            nk=[rit rit];
            modello=arx(dati_id,[na,nb,nk]);
            lista_modelli{cont}=modello;
            % struttura(cont,:)=[na,nb,nk];
            dati_prev=predict(modello,dati_id, orizzonte_previsione);
            % MAE(cont)=mean(abs(dati_prev3.y-dati_val.y));
            
            FPE(cont)=fpe(modello);
            % e = vettore dei residui
            % d = numero dei parametri del modello
            % L = il numero dei dati
    
            % L=length(dati_id.y)
            % d=na+nb;
            % dati_out_id=predict(modello,dati_id,orizzonte_di_previsione)
            % e=dati_out_id.y-dati_id.y;
            % fpe(cont)=e'*e/L*(1+d/L)/(1-d/L);
            c=corrcoef(dati_prev.y,dati_id.y);
            correlazione(cont)=c(2,1);
        end
    end
end
 [FPE_best,imodel_best]=min(FPE)
 modello_best=lista_modelli{imodel_best}
 correlazione_best=correlazione(imodel_best);
 present(modello_best)


%  (b) Indicare, motivando la risposta, se l’utilizzo degli ingressi 
% esogeni porta a significativi (a vostro avviso)
% miglioramenti nelle prestazioni del sistema in termini di ME, MAE e correlazione. 
% Indicare inoltre, a vostro giudizio e motivando la risposta, 
% quale `e l ingresso maggiormente impattante in temrini di prestazioni.

dati_prev=predict(modello_best,dati_val, orizzonte_previsione)
e=dati_prev.y-dati_val.y;
ME=mean(e)
MAE=mean(abs(e))

corr=corrcoef(dati_prev.y,dati_val.y)% se dinamicamente il nostro modello ci becca
corr=corr(2,1)%


% copia ciclo e fai partire iex1 a iex2


% lunedì
