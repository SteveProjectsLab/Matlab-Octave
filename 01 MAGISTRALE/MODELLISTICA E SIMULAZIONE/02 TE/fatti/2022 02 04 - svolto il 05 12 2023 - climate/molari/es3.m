load 'MODELLISTICA E SIMULAZIONE'\'00 TE'\'2022 02 04'\climate.mat

% ho un solo ingresso e ci interessa solo l'uscita o1

% Tc = tempo di coglionamento
dati=iddata(climate(:,3),climate(:,1:2));
dati_id=dati(1:400);
dati_val=dati(401:end);

max_ordine_ar=2; % se viene non intero usare round(18/Tc)
max_ordine_eso=2;%num ingressi
rit=0;



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

       dati_out_val_sim=sim(modello_migliore,dati_val);
        e_val=dati_out_val_sim.y-dati_val.y;
    end
end

 [min_fpe,imin]=min(fpe);
 modello_migliore=lista_modelli{imin}



%simulazione
dati_out_val_sim=sim(modello_migliore,dati_val);
e_val=dati_out_val_sim.y-dati_val.y;
NME_sim=mean(e_val)/mean(dati_val.y)
NMAE_sim=mean(abs(e_val))/mean(dati_val.y)
CORR_sim=corrcoef(dati_out_val_sim.y,dati_val.y);
CORR_sim=CORR_sim(2,1)

e=ypred_v-y_v;
ME=mean(e)
MAE=mean(abs(e))

