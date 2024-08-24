clear all
load cstr.mat
% ho un solo ingresso e ci interessa l'uscita o1 (prima colonna)
dati=iddata(Y(:,1),U,Tc);
dati_id=dati(1:6000); % dataset di identificazione
dati_val=dati(6001:end); % dataset di validazione

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
        modello=arx(dati_id,[na,nb,nk]);
        lista_modelli{cont}=modello; % occhio alle graffe!!!!
        struttura(cont,:)=[na,nb,nk];
        % devo selezionare il modello migliore come rapporto
        % complessità/prestazioni => FPE
        d=na+nb;
        L=length(dati_id.y);
        dati_out_id=predict(modello,dati_id,orizzonte_previsione);
        e=dati_out_id.y-dati_id.y;
        fpe(cont)=e'*e/L*(1+d/L)/(1-d/L); % e: vettore dei residui; 
        % d=numero dei parametri modello; 
        % L: il  numero dei dati
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

