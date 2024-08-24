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
%##########################################################################
%                               IDENTIFICAZIONE
%##########################################################################
% devo testare tutti i modelli che posso avere per prevedere la mia uscita
cont=0;
for iar=1:max_ord_ar
    for iex=0:max_ord_ex % nei problemi di previsione potrei non avere l'input
        cont=cont+1;
        na=iar;
        nb=iex;
        nk=rit;

        modello=arx(dati_id,[na,nb,nk]);
        dati_out_id=predict(modello,dati_id,orizzonte_previsione); 
        
        d=na+nb;                     
        L=length(dati_id.y);        
        e=dati_out_id.y-dati_id.y;  
        
        FPE=e'*e/L*(1+d/L)/(1-d/L); 
        % NB caso peggiore d=L va a zero il denominatore
        s.cont=cont;
        s.model=modello;
        s.orders=[iar iex rit];
        s.fpe=FPE;
        s.data=dati_out_id;
        
        lista_modelli{cont}=s; % occhio alle graffe!!!!
        %struttura(cont,:)=[na,nb,nk];
        % devo selezionare il modello migliore come rapporto
        % complessità/prestazioni => FPE
        
       
        
    end
end

min_fpe=min(s.fpe); 
fprintf("FPE minimo:%f\n",min_fpe)
modello_migliore=lista_modelli{cont}
fprintf("il modello migliore è il seguente:\n")
modello_migliore.model

%##########################################################################
% VALIDAZIONE
%##########################################################################
% % a questo punto faccio la validazione (non era richiesta dall'esercizio, uso NME, NMAE, CORR)

fprintf("Validazione del modello in previsione\n")
dati_out_val=predict(modello_migliore.model,dati_val,orizzonte_previsione);
e_val=dati_out_val.y-dati_val.y;
NME=mean(e_val)/mean(dati_val.y)
NMAE=mean(abs(e_val))/mean(dati_val.y)
CORR=corrcoef(dati_out_val.y,dati_val.y);
CORR=CORR(2,1)

fprintf("Validazione del modello in simulazione\n")
% come si comporta il sistema in simulazione?
dati_out_val_sim=sim(modello_migliore.model,dati_val);
e_val=dati_out_val_sim.y-dati_val.y;
NME_sim=mean(e_val)/mean(dati_val.y)
NMAE_sim=mean(abs(e_val))/mean(dati_val.y)
CORR_sim=corrcoef(dati_out_val_sim.y,dati_val.y);
CORR_sim=CORR_sim(2,1)

