clear
close all
clc

load energy.mat

% uscita: c1
% ingressi c2

lung_data_id=length(energy(:,1))*0.80
y=energy(:,1);
u=energy(:,2:3);
Tc=1;

dati=iddata(y,u,Tc);
dati_id=dati(1:lung_data_id);
dati_val=dati(lung_data_id+1:end);

na_max=2;
nb_max=2;
nk=[0 0];

%orizzonte_previsione=3;

cont=0;
for iar=1:na_max
    for iex1=0:nb_max% è un problema di previsione per cui posso accettare di non avere ingressi
        for iex2=0:nb_max
            cont=cont+1;
            order=[iar,[iex1 iex2],nk];
            struttura(cont,:)=order;
            npar=sum(order);
            modello=arx(dati_id,order);
            lista_modelli{cont}=modello;
            dati_out=predict(modello,dati_id);
            e=dati_out.y-dati_id.y;
            FPE(cont)=(e'*e)/1920*(1+npar/1920)/(1-npar/1920);
            % MAE(cont)=mean(abs(dati_prev3.y-dati_val.y));
            
            %FPE(cont)=fpe(modello);
            % e = vettore dei residui
            % d = numero dei parametri del modello
            % L = il numero dei dati
    
            % L=length(dati_id.y)
            % d=na+nb;
            % dati_out_id=predict(modello,dati_id,orizzonte_di_previsione)
            % e=dati_out_id.y-dati_id.y;
            % fpe(cont)=e'*e/L*(1+d/L)/(1-d/L);
            
            dati_out_val=predict(modello,dati_val,3);
            yval
            me_val=mean(e_val)
            c=corrcoef(y_valy,dati_val.y);
            correlazione(cont)=c(2,1);
        end
    end
end
 [FPE_best,imodel_best]=min(FPE);
 modello_best=lista_modelli{imodel_best}
 correlazione_best=correlazione(imodel_best);
 present(modello_best)


%  modello_best =                                                                                                                                                                                                                                                                                                                             
% Discrete-time ARX model: A(z)y(t) = B(z)u(t) + e(t)                                                                                                                                                                                                                                                                                        
%   A(z) = 1 - 0.9243 (+/- 0.0082) z^-1 - 0.07306 (+/- 0.008609) z^-2                                                                                                                                                                                                                                                                        
% 
%   B1(z) = -2.377 (+/- 0.0245) + 2.306 (+/- 0.0276) z^-1                                                                                                                                                                                                                                                                                    
% 
%   B2(z) = -0.2021 (+/- 0.01241) + 0.2366 (+/- 0.0121) z^-1 


%FPE_best =   43.6628
%%

%  (b) Indicare, motivando la risposta, se l’utilizzo degli ingressi 
% esogeni porta a significativi (a vostro avviso)
% miglioramenti nelle prestazioni del sistema in termini di ME, MAE e correlazione. 
% Indicare inoltre, a vostro giudizio e motivando la risposta, 
% quale `e l ingresso maggiormente impattante in temrini di prestazioni.


% vedere il migliore
% cerco i valori migliori di me, mae, corr
[me_best,ime_best]=min(me_val);
ime_best_struct
[mae_best,imae_best]=min(mae_val)


% verifico che hanno gli ingressi i modelli migliori

icorr_best_struct=struttura(icorr,best,:)


% sul mae abbiamo il modello mifliore
% sul min error no

% senza fare il valore assoliuto prendiamo quellopiù negativo, mentre il
% più basso è quelo vicino a 0


% le prestazioni migliorano con l'utilizzo degli ingressi
% migliorano in modo consistente?
% segnarsi i casi puri


% gli ingressi impattano tantissimo sulle prestazioni



% su quale ingresso funziona meglio?


% prendiamo modelli che hanno solo primo ingresso
% prendiamo modelli che hanno solo secondo ingresso
%e li confrontiamo
 modelli_ingresso1[4:9,13:18];
 
