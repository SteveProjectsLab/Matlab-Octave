%##########################################################################
% esercizio 3
%##########################################################################
%##########################################################################
% punto a
%##########################################################################
% (a) Scrivere lo script matlab che permetta di scegliere il modello migliore
% come compromesso prestazioni/complessità motivando la risposta.
% Per il modello selezionato riportare le prestazioni (correlazione e MAE)
% in validazione% sulla previsione a 1 mese e a 3 mesi.
% Utilizzare 180 dati del dataset per l’identificazione (i primi) e i
% restanti la validazione.
% per scegliere il modello migliore come compromesos
% prestazioni/complessità devo valutare l'FPE di tutti e trovare il modello
% con il minimo FPE
% carico i dati
load manila_river.mat
dati=iddata(portata,precip);
dati_id=dati(1:180);
dati_val=dati(181:end);
na_max=2; % coeff massimi parte auto regressiva
nb_max=2; % coeff massimi parte esogena
nk=0; % ritardo
orizzonte_previsione=1;
% calcolo i modelli
cont=0;
for iar=1:na_max
    for iex=0:nb_max% datoche è una previsione posso partire da 0
        cont=cont+1;
        na=iar;
        nb=iex;
        nk=0;
        modello=arx(dati_id,[na nb nk]);
        dati_out=predict(modello,dati_id,orizzonte_previsione);
        lista_modelli{cont}=modello;
        struttura(cont,:)=[na nb nk];
        d=na+nb;
        L=length(dati_id.y);% lunghezza serie dati
        e=dati_out.y-dati_id.y;
        FPE(cont)=e'*e/L*(1+d/L)/(1-d/L);
    end
end
[FPE_best,imodel]=min(FPE)
modello_migliore=lista_modelli{imodel}
present(modello_migliore)