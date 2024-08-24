load climate.mat
% ho un solo ingresso e ci interessa solo l'uscita o1
% Tc = tempo di coglionamento
dati=iddata(climate(:,3),climate(:,1:2));
% se ho più di un input devo passare gli input in un'unica matrice
dati_id=dati(1:400);
dati_val=dati(401:end);
passo_previsione=3; % anni
na_max=2; % se viene non intero usare round(18/Tc)
nb_max=2;% num ingressi
nk=0;
rit=0;
% devo testare tutti i modelli che posso avere per prevedere la mia uscita
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
            struttura(cont,:)=[na,nb,nk];
            dati_prev3=predict(modello,dati_val, passo_previsione);
            abs_error(cont)=mean(abs(dati_prev3.y-dati_val.y));
            c=corrcoef(dati_prev3.y,dati_val.y);
            correlazione(cont)=c(2,1)
        end
    end
end
 [abs_error_best,imodel_best]=min(abs_error);
 modello_best=lista_modelli{imodel_best}
 correlazione_best=correlazione(imodel_best);
 present(modello_best)



