load cstr.mat

% ho un solo ingresso e ci interessa solo l'uscita o1

% Tc = tempo di coglionamento
dati=iddata(Y(:,1),U,Tc);
dati_id=dati(1:6000);
dati_val=dati(6001:end);

max_ordine_ar=18/Tc; % se viene non intero usare round(18/Tc)
max_ordine_eso=18/Tc;
rit=0;

orizzonte_di_previsione=30/Tc;

% devo testare tutti i modelli che posso avere per prevedere la mia uscita
cont=0;
for iar=1:max_ordine_ar
    for iex=0:max_ordine_eso % nei problemi di previsione potrei non avere l'input
        cont=cont+1;
        na=iar;
        nb=iex;
        nk=rit;
        modello=arx(dati_id,[na,nb,nk]);
        lista_modelli{cont}=modello;
        struttura(cont,:)=[na,nb,nk]%matrice che ha per ogni riga la struttura del modello
        % devo selezionare il modello migliore come rapport
        % complessità/prestazioni => FPE

        % e = vettore dei residui
        % d = numero dei parametri del modello
        % L = il numero dei dati

        L=length(dati_id.y)
        d=na+nb;
        dati_out_id=predict(modello,dati_id,orizzonte_di_previsione)
        e=dati_out_id.y-dati_id.y;
        fpe(cont)=e'*e/L*(1+d/L)/(1-d/L);
       
    end
end

 [min_fpe,imin]=min(fpe);
 modello_migliore=lista_modelli{imin}

 %predizione
 dati_out_val=predict(modello_migliore,dati_val,orizzonte_di_previsione);
 e_val=dati_out_val.y-dati_val.y;
NME=mean(e_val)/mean(dati_val.y)
NMAE=mean(abs(e_val))/mean(dati_val.y)
CORR=corrcoef(dati_out_val.y,dati_val.y);
CORR=CORR(2,1)

 %simulazione
  dati_out_val_sim=sim(modello_migliore,dati_val,orizzonte_di_previsione);
 e_val=dati_out_val_sim.y-dati_val.y;
NME_sim=mean(e_val)/mean(dati_val.y)
NMAE_sim=mean(abs(e_val))/mean(dati_val.y)
CORR_sim=corrcoef(dati_out_val_sim.y,dati_val.y);
CORR_sim=CORR_sim(2,1)


