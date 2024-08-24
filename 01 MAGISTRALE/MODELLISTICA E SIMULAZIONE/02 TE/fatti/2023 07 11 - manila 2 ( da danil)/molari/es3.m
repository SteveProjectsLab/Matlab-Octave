close all
clear
clc
%--------------------------------------------------------------------------
% punto a
%--------------------------------------------------------------------------

% prevedere a 1 anno l'andamento del livello delle acque, in funzione
% dell'anomalia di temperatura

% a disposizione i dati mensili di "sealevel" e "ta" (temperature anomaly)

% la relazione causa-effetto tra le due quantità ha le seguenti caratteristiche:
% - L impatto dell-anomalia di temperatura, data la lentezza del fenomeno, 
%       si inizia a vedere dopo 1 anno sul livello del mare;
% - La memoria della parte autoregressiva del sistema `e pari al massimo pari a 2.
% - La memoria della parte esogena `e pari al massimo pari a 1.

load manila_sea.mat
dati=iddata(sealev,ta);
dati_id=dati(1:170);
dati_val=dati(170:end);

na_max=2
nb_max=1
rit=12;% un anno, 12 mesi, i dati erano presi mensilmente

orizzonte_previsione=12;%mesi

count=0;
for iar=1:na_max
    for iex=0:nb_max % nei problemi di previsione potrei non avere l'input
        count=count+1;
        na=iar;
        nb=iex;
        nk=rit;
        modello=arx(dati_id,[na,nb,nk]);
        lista_modelli{count}=modello;
        struttura(count,:)=[na,nb,nk]%matrice che ha per ogni riga la struttura del modello
        % devo selezionare il modello migliore in termini di MAE
        dati_prev=predict(modello,dati_val, orizzonte_previsione);
        MAE(count)=mean(abs(dati_prev.y-dati_val.y));
        c=corrcoef(dati_prev.y,dati_val.y);
        correlazione(count)=c(2,1)
    end
end

[MAE_best,imodel_best]=min(MAE);
modello_best=lista_modelli{imodel_best}
correlazione_best=correlazione(imodel_best);
present(modello_best)

%--------------------------------------------------------------------------
% punto b
%--------------------------------------------------------------------------
% Si vuole utilizzare il modello identificato per prevedere il valore 
% del livello del mare con un anticipo almeno annuale, al fine di poter 
% prendere con relativo anticipo le contromisure adeguate. 
% Considerando una soglia di correlazione di 0.6 come soglia di 
% accettabilit`a delle prestazioni, indicare con quanti anni di 
% anticipo si possono effettuare adeguatamente le previsioni.

%previsione a un anno
dati_prev_1=predict(modello_best,dati_val,orizzonte_previsione);
MAE_1=mean(abs(dati_prev_1.y-dati_val.y));
corr_1=corrcoef(dati_prev_1.y,dati_val.y);
corr_1=corr_1(2,1);
fprintf('\tCorrelazione dopo un anno: %f\n',corr_1);

%previsione a due ann1
dati_prev_2=predict(modello_best,dati_val,2*orizzonte_previsione);
MAE_2=mean(abs(dati_prev_2.y-dati_val.y));
corr_2=corrcoef(dati_prev_2.y,dati_val.y);
corr_2=corr_2(2,1);
fprintf('\tCorrelazione dopo due anni: %f\n',corr_2);
%--------------------------------------------------------------------------
% punto c
%--------------------------------------------------------------------------
%Il modello può effettuare previsioni distanti un solo anno dalla raccolta dei dati, 
% in quanto la correlazione tra i dati previsti dopo due anni e quelli misurati scende
% al di sotto della soglia desiderata
% Correlazione dopo un anno: 0.675822
% Correlazione dopo due anni: 0.417105
