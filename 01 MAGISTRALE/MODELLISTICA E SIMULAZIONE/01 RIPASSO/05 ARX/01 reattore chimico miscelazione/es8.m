clear all
clc


%##########################################################################
% Si vuole progettare un modello arx per la risoluzione di un
% problema di previsione fino a 30 secondi della concentrazione di
% prodotto sviluppata da un reattore chimico a miscelazione continua.

% Il sistema prevede l’immissione di reagenti (controllabile) nel
% serbatoio e una “pala” che permette di mescolare la miscela al fine
% di ottenere dei prodotti di reazione.
% Sul sistema NON si possono fare test, ma sono disponibili dei dati,
% campionati ogni 6 secondi. 
% 
% I dati, tutti validi, sono contenuti nel file
% cstr.mat che contiene anche delle brevi descrizioni delle variabili.

% Il sistema ha un memoria massima di 18 secondi sia per quanto
% riguarda l’uscita che per quanto riguarda gli ingressi. 
% Non c’è motivo di supporre ritardo tra uscita e ingressi.

% Si vuole determinare, in queste condizioni e utilizzando 6000 dati
% per la identificazione e i restanti per la validazione, il modello arx
% migliore per il problema in esame come rapporto complessità/
% prestazioni.
%##########################################################################

load cstr.mat
% ho un solo ingresso e ci interessa l'uscita o1 (prima colonna)
dati=iddata(Y(:,1),U,Tc);
dati_id=dati(1:6000); % dataset di identificazione
dati_val=dati(6001:end); % dataset di validazione

%Tc=6;
max_ord_ar=18/Tc; % se viene non intero usare round(18/Tc)
max_ord_ex=18/Tc;
rit=0;

orizzonte_previsione=30/Tc;

% devo testare tutti i modelli che posso avere per prevedere la mia uscita
cont=0;
for iar=1:max_ord_ar
    for iex=0:max_ord_ex % nei problemi di previsione potrei non avere l'input
        cont=cont+1;
        na=iar;
        nb=iex;
        nk=rit;

        modello=arx(dati_id,[na,nb,nk]); %IDENTIFICAZIONE

        lista_modelli{cont}=modello; % occhio alle graffe!!!!
        struttura(cont,:)=[na,nb,nk];
        % devo selezionare il modello migliore come rapporto
        % complessità/prestazioni => FPE
        
        % NB se chiede FPE usa i dati in identificazione
        dati_out_id=predict(modello,dati_id,orizzonte_previsione); % VALIDAZIONE 
        
        d=na+nb;                    % d=numero dei parametri modello; 
        % NB se nb è un vettore, devo fare la somma dei suoi elementi
        % usa comando sum o nb(1)+nb(2)
        L=length(dati_id.y);        % L: il  numero dei dati
        e=dati_out_id.y-dati_id.y;  % e: vettore dei residui; 
        
        fpe(cont)=e'*e/L*(1+d/L)/(1-d/L); 
        % NB caso peggiore d=L va a zero il denominatore
        
    end
end

[min_fpe,imin]=min(fpe); % imin è l'indice del modello che ha fpe minimo
modello_migliore=lista_modelli{imin}

% a questo punto faccio la validazione (non era richiesta dall'esercizio, uso NME, NMAE, CORR)
dati_out_val=predict(modello_migliore,dati_val,orizzonte_previsione);
e_val=dati_out_val.y-dati_val.y;
NME=mean(e_val)/mean(dati_val.y)
NMAE=mean(abs(e_val))/mean(dati_val.y)
CORR=corrcoef(dati_out_val.y,dati_val.y);
CORR=CORR(2,1)

% come si comporta il sistema in simulazione?
dati_out_val_sim=sim(modello_migliore,dati_val);
e_val=dati_out_val_sim.y-dati_val.y;
NME_sim=mean(e_val)/mean(dati_val.y)
NMAE_sim=mean(abs(e_val))/mean(dati_val.y)
CORR_sim=corrcoef(dati_out_val_sim.y,dati_val.y);
CORR_sim=CORR_sim(2,1)

% ( in più) considero l'incertezza dei parametri

