% Si vuole determinare il modello di un sistema di fornitura di energia 
% per poter in seguito prevedere a 3 ore 
% la fornitura necessaria in funzione della temperatura e dell’umidità
% relativa dellàarea a cui il sistema dovrà fornire energia.

% (a) Vi si chiede di progettare il software necessario alla selezione 
% automatica del modello tenendo presente che:
% • Il tempo di campionamento `e di 1 ora.
% • Dati sono contenuti nel file energy.mat 
% (c1: energia; c2: temperatura, c3: umidit`a) e sono TUTTI DATI VALIDI.
% • Non si conoscono ritardi apprezzabili 
% tra le variazioni degli ingressi e il loro impatto sull’uscita.
% • Si vuole mantenere un modello che ha al massimo 2 coefficienti 
% per la parte autoregressiva e 2 (a testa, sempre massimo) per i due ingressi.

% • L’identificazione dovrà essere realizzata considerando le prestazioni ad 1 ora,
% ma la selezione del modello  migliore andr`a fatta sulla base del FPE 
%NB!!!! questa specifica veniva usata sugli altri anni, l'fpe si fa
%sull'identificazione


% sul problema da risolvere (si veda inizio esercizio).
% • Si utilizza l’80% del dataset per l’identificazione 
% e il restante 20% per la validazione

clear all
clc

load 'MODELLISTICA E SIMULAZIONE'\'01 RIPASSO'\'05 ARX'\'04 energy ripassone 2023 12 11'\test\energy.mat
y=energy(:,1);
u=energy(:,2:3);
Tc=1;   %ora
horizon=3; %ore

dati=iddata(y,u,Tc)
dataset_length=length(dati.y)
id_data=dati(1:0.8*dataset_length);
val_data=dati(0.8*dataset_length+1:end);

na_max=2;
nb_max=2
nk=0;

i=0;    % indice

for iar=1:na_max
    for iex1=0:nb_max
        for iex2=0:nb_max
            % identificazione
            i=i+1;
            orders=[iar,[iex1 iex2],[nk nk]];
            model=arx(id_data,orders);
            lista_modelli{i}=model;
            struttura(i,:)=orders;
            y_id=predict(model,id_data);
            e=y_id.y-id_data.y;
            d=iar+iex1+iex2;
            L=length(id_data.y);
            FPE(i)=e'*e/L*(1+d/L)/(1-d/L);

            %validazione
            y_val=predict(model,val_data,horizon);
            e_val=y_val.y-val_data.y;
            ME_val(i)=mean(e_val);
            MAE_val(i)=mean(abs(e_val));
            c=corrcoef(y_val.y,val_data.y);
            CORR_val(i)=c(2,1);
        end
    end
end

[FPE_best,ibest]=min(FPE);
best_model=lista_modelli{ibest};
fprintf('il modello migliore, con FPE pari a %.4f è:\n',FPE_best);
present(best_model);

%##########################################################################
% il modello migliore, con FPE pari a 43.6628 è:

% best_model =                                                                                                                                                                                                                                                                                                                     
% Discrete-time ARX model: A(z)y(t) = B(z)u(t) + e(t)                                                                                                                                                                                                                                                                              
% 
%   A(z) = 1 - 0.9243 (+/- 0.0082) z^-1 - 0.07306 (+/- 0.008609) z^-2                                                                                                                                                                                                                                                              
% 
%   B1(z) = -2.377 (+/- 0.0245) + 2.306 (+/- 0.0276) z^-1                                                                                                                                                                                                                                                                          
% 
%   B2(z) = -0.2021 (+/- 0.01241) + 0.2366 (+/- 0.0121) z^-1                                                                                                                                                                                                                                                                       
% 
% Sample time: 1 seconds                                                                                                                                                                                                                                                                                                           
% 
% Parameterization:                                                                                                                                                                                                                                                                                                                
%    Polynomial orders:   na=2   nb=[2 2]   nk=[0 0]                                                                                                                                                                                                                                                                               
%    Number of free coefficients: 6                                                                                                                                                                                                                                                                                                
%    Use "polydata", "getpvec", "getcov" for parameters and their uncertainties.                                                                                                                                                                                                                                                   
% 
% Status:                                                                                                                                                                                                                                                                                                                          
% Estimated using ARX on time domain data "id_data".                                                                                                                                                                                                                                                                               
% Fit to estimation data: 61.07% (prediction focus)                                                                                                                                                                                                                                                                                
% FPE: 43.75, MSE: 43.39                                                                                                                                                                                                                                                                                                           
% More information in model's "Report" property.   
%##########################################################################
% (b) Indicare, motivando la risposta, se l’utilizzo degli ingressi esogeni 
% porta a significativi (a vostro avviso)
% miglioramenti nelle prestazioni del sistema in termini di ME, MAE e correlazione. 
% Indicare inoltre, a vostro giudizio e motivando la risposta,
% quale `e l ingresso maggiormente impattante in temrini di prestazioni.


%##########################################################################
% scelta in base al ME migliore
[me_best,ime_best]=min(abs(ME_val));
ime_best_struct=struttura(ime_best,:)

%##########################################################################
% scelta in base al MAE migliore
[mae_best,imae_best]=min(MAE_val);
imae_best_struct=struttura(imae_best,:)

%##########################################################################
% scelta in base alla correlazione migliore
[corr_best,icorr_best]=max(CORR_val);
icorr_best_struct=struttura(icorr_best,:)


%##########################################################################
% ime_best_struct =     1     2     0     0     0
% imae_best_struct =     1     2     2     0     0
% icorr_best_struct =     1     2     2     0     0
%##########################################################################

% Le prestazioni migliorano con l'utilizzo degli ingressi


% Migliorano in modo consistente?
% struttura =
%  i     na    nb1   nb2   nk    nk       descrizione
%  1     1     0     0     0     0    %ar puro (no ingressi)
%  2     1     0     1     0     0            %solo 2
%  3     1     0     2     0     0            %solo 2
%  4     1     1     0     0     0        %solo 1
%  5     1     1     1     0     0                %entrambi
%  6     1     1     2     0     0                %entrambi
%  7     1     2     0     0     0        %solo 1
%  8     1     2     1     0     0                %entrambi
%  9     1     2     2     0     0                %entrambi
%  10    2     0     0     0     0   % ar puro (no ingressi)
%  11    2     0     1     0     0            %solo 2
%  12    2     0     2     0     0            %solo 2
%  13    2     1     0     0     0        %solo 1
%  14    2     1     1     0     0                %entrambi
%  15    2     1     2     0     0                %entrambi
%  16    2     2     0     0     0        %solo 1
%  17    2     2     1     0     0                %entrambi
%  18    2     2     2     0     0                %entrambi

% casi senza ingressi sono AR(1),AR(2)
% posizioni in struttura => 1 (AR(1)) e 10 (AR(2))

% inizio a vedere i modelli che non hanno ingressi
[me_best,ME_val([1,10])]
[mae_best,MAE_val([1,10])]
[corr_best,CORR_val([1,10])]

% NB guarda da sx a dx -->
% a destra ho quelli senza ingressi

% ans =    0.0928   -1.8721   -0.8042
% ans =    5.0381   19.2798   16.5277
% ans =    0.9263   -0.0611   -0.0301

% gli ingressi impattano tantissimo sulle prestazioni

%##########################################################################
% Quale ingresso funziona meglio?
% Prendo le strutture con i soli ingressi

modelli_ingresso1=[4,7,13,16];  % hanno solo il primo ingresso
modelli_ingresso2=[2,3,11,12,]; % hanno solo il secondo ingresso

struttura_ingresso1=struttura(modelli_ingresso1,:);
modelli_lista_ingresso1=lista_modelli{modelli_ingresso2};
me_val_ingresso1=ME_val(modelli_ingresso1);
mae_val_ingresso1=MAE_val(modelli_ingresso1);
correl_ingresso1=CORR_val(modelli_ingresso1);
[me_best,ime_best]=min(abs(me_val_ingresso1));
ime_best_struct=struttura_ingresso1(ime_best,:)
[mae_best,imae_best]=min(mae_val_ingresso1);
imae_best_struct=struttura_ingresso1(imae_best,:)
[corr_best,icorr_best]=max(correl_ingresso1);
icorr_best_struct=struttura_ingresso1(icorr_best,:)

% ime_best_struct =     1     2     0     0     0
% imae_best_struct =     1     2     0     0     0
% icorr_best_struct =     1     2     0     0     0

struttura_ingresso2=struttura(modelli_ingresso2,:);
modelli_lista_ingresso2=lista_modelli{modelli_ingresso2};
me_val_ingresso2=ME_val(modelli_ingresso2);
mae_val_ingresso2=MAE_val(modelli_ingresso2);
correl_ingresso2=CORR_val(modelli_ingresso2);
[me_best2,ime_best]=min(abs(me_val_ingresso2));
ime_best_struct=struttura_ingresso2(ime_best,:)
[mae_best2,imae_best]=min(mae_val_ingresso2);
imae_best_struct=struttura_ingresso2(imae_best,:)
[corr_best2,icorr_best]=max(correl_ingresso2);
icorr_best_struct=struttura_ingresso2(icorr_best,:)

% ime_best_struct =     2     0     1     0     0
% imae_best_struct =     2     0     2     0     0
% icorr_best_struct =     2     0     2     0     0

% poi confrontare tutto di 1 con tutto di 2
