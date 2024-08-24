clear all
clc

load energy
dati=iddata(energy(:,1),[energy(:,2),energy(:,3)]);
dati_id=dati(1:1920);
dati_val=dati(1921:end);

nk=[0 0];
na_max=2;
nb_max=2;

% problema di previsione, per cui posso accettare di non avere ingressi 
% (nb_min=0)

cont=0;
for iar=1:na_max
    for iex1=0:nb_max
        for iex2=0:nb_max
            cont=cont+1;
            order=[iar,[iex1,iex2],nk];
            struttura(cont,:)=order;
            npar=sum(order);
            modello=arx(dati_id,order);
            modelli_lista{cont}=modello;
            dati_out=predict(modello,dati_id);
            e=dati_out.y-dati_id.y;
            fpe(cont)=(e'*e)/1920*(1+npar/1920)/(1-npar/1920);
            dati_out_val=predict(modello,dati_val,3);
            y_val=dati_out_val.y;
            e_val=y_val-dati_val.y;
            me_val(cont)=mean(e_val);
            mae_val(cont)=mean(abs(e_val));
            c=corrcoef(y_val,dati_val.y);
            correl(cont)=c(2,1);
        end
    end
end

[fpe_best,ibest]=min(fpe);
modello_best=modelli_lista{ibest};

% modello_best =
% Discrete-time ARX model: A(z)y(t) = B(z)u(t) + e(t)
%   A(z) = 1 - 0.9243 z^-1 - 0.07306 z^-2            
% 
%   B1(z) = -2.377 + 2.306 z^-1                      
% 
%   B2(z) = -0.2021 + 0.2366 z^-1 

%fpe_best=43.6628

% cerco i migliori valori di me, mae, corr
[me_best,ime_best]=min(abs(me_val));
ime_best_struct=struttura(ime_best,:)
[mae_best,imae_best]=min(mae_val);
imae_best_struct=struttura(imae_best,:)
[corr_best,icorr_best]=max(correl);
icorr_best_struct=struttura(icorr_best,:)

% Le prestazioni migliorano con l'utilizzo degli ingressi
% Migliorano in modo consistente?
% casi senza ingressi sono AR(1),AR(2)
% posizioni in struttura => 1 (AR(1)) e 10 (AR(2))

[me_best,me_val([1,10])]
[mae_best,mae_val([1,10])]
[corr_best,correl([1,10])]

% gli ingressi impattano tantissimo sulle prestazioni

% Quale ingresso funziona meglio?
% Prendo le strutture con i soli inressi
modelli_ingresso1=[4,7,13,16];
modelli_ingresso2=[2,3,11,12,];

struttura_ingresso1=struttura(modelli_ingresso1,:);
modelli_lista_ingresso1=modelli_lista{modelli_ingresso2};
me_val_ingresso1=me_val(modelli_ingresso1);
mae_val_ingresso1=mae_val(modelli_ingresso1);
correl_ingresso1=correl(modelli_ingresso1);
[me_best,ime_best]=min(abs(me_val_ingresso1));
ime_best_struct=struttura_ingresso1(ime_best,:)
[mae_best,imae_best]=min(mae_val_ingresso1);
imae_best_struct=struttura_ingresso1(imae_best,:)
[corr_best,icorr_best]=max(correl_ingresso1);
icorr_best_struct=struttura_ingresso1(icorr_best,:)

struttura_ingresso2=struttura(modelli_ingresso2,:);
modelli_lista_ingresso2=modelli_lista{modelli_ingresso2};
me_val_ingresso2=me_val(modelli_ingresso2);
mae_val_ingresso2=mae_val(modelli_ingresso2);
correl_ingresso2=correl(modelli_ingresso2);
[me_best2,ime_best]=min(abs(me_val_ingresso2));
ime_best_struct=struttura_ingresso2(ime_best,:)
[mae_best2,imae_best]=min(mae_val_ingresso2);
imae_best_struct=struttura_ingresso2(imae_best,:)
[corr_best2,icorr_best]=max(correl_ingresso2);
icorr_best_struct=struttura_ingresso2(icorr_best,:)
