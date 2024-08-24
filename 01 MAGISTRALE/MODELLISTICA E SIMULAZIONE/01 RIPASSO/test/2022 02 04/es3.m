% Si vuole modellizzare l’impatto delle emissioni di CO2 sull’anomalia di temperatura per poter realizzare successivamente
% un sistema di controllo basato su interventi sulle emissioni.
% (a) Scrivere uno script MATLAB che permetta di identificare e validare i modelli che legano emissioni e anomalia
% di temperatura, tenendo conto che:
% • Il tempo di campionamento `e di 1 anno.
% • I dati sono contenuti nel file climate.mat (c1: emissioni di CO2; c2: emissioni di CH4, c3: anomalia di
% temperatura) e sono TUTTI DATI VALIDI.
% • Non si conoscono ritardi apprezzabili tra le variazioni delle emissioni e il loro impatto sull’anomalia di
% temperatura.
% • Si vuole mantenere un modello che abbia al massimo 2 coefficienti per la parte autoregressiva e 2 per
% quella esogena.
% • Si utilizzano 400 dati del dataset per l’identificazione (i primi) e i restanti la validazione.
% • Selezionare il modello migliore per il problema in esame sulla base del MAE.


% (b) Presentare per il modello migliore:
% • la struttura del modello
% • le prestazioni sul dataset di validazione in termini di MAE e correlazione.
% • l’intervallo di confidenza al 95% dei parametri stimati


clear all
clc

load 'MODELLISTICA E SIMULAZIONE'\'01 RIPASSO'\test\'2022 02 04'\climate.mat
%(c1: emissioni di CO2; c2: emissioni di CH4, c3: anomalia di temperatura)
y=climate(:,3);
u=climate(:,1:2);
Tc=1;   %anno

data=iddata(y,u,Tc);
id_data=data(1:400);
val_data=data(401:end);

na_max=2;
nb_max=2;
nk=0;

horizon=3;  %anni
i=0;
for iar=1:na_max
    for iex1=0:nb_max
        for iex2=0:nb_max
            i=i+1;
            orders=[iar,[iex1 iex2],[nk nk]];
            model=arx(id_data,orders);
            model_list{i}=model;
            structure{i}=orders;
            y_val=predict(model,val_data,horizon);
            e_val=y_val.y-val_data.y;
            MAE(i)=mean(abs(e_val));
            c=corrcoef(y_val.y,val_data.y);
            CORR(i)=c(2,1);
        end
    end
end
[MAEbest,ibest]=min(MAE);
best_model=model_list{ibest};
fprintf('il modello migliore è:\n')
present(best_model);
fprintf('\nla correlazione del modello migliore è: %f',CORR(ibest))


%il modello migliore è:
                                                                                                                                                                                                                                                                                                                                 
% best_model =                                                                                                                                                                                                                                                                                                                     
% Discrete-time ARX model: A(z)y(t) = B(z)u(t) + e(t)                                                                                                                                                                                                                                                                              
%   A(z) = 1 - 1.592 (+/- 0.04061) z^-1 + 0.5923 (+/- 0.04063) z^-2                                                                                                                                                                                                                                                                
% 
%   B1(z) = 0.0006351 (+/- 9.95e-05)                                                                                                                                                                                                                                                                                               
% 
%   B2(z) = 0                                                                                                                                                                                                                                                                                                                      
% 
% Sample time: 1 seconds                                                                                                                                                                                                                                                                                                           
% 
% Parameterization:                                                                                                                                                                                                                                                                                                                
%    Polynomial orders:   na=2   nb=[1 0]   nk=[0 1]                                                                                                                                                                                                                                                                               
%    Number of free coefficients: 3                                                                                                                                                                                                                                                                                                
%    Use "polydata", "getpvec", "getcov" for parameters and their uncertainties.                                                                                                                                                                                                                                                   
% 
% Status:                                                                                                                                                                                                                                                                                                                          
% Estimated using ARX on time domain data "id_data".                                                                                                                                                                                                                                                                               
% Fit to estimation data: 99.26% (prediction focus)                                                                                                                                                                                                                                                                                
% FPE: 0.0001005, MSE: 9.799e-05                                                                                                                                                                                                                                                                                                   
% More information in model's "Report" property.                                                                                                                                                                                                                                                                                   
% 
% Model Properties
% 
% la correlazione del modello migliore è: 1.000000>> 

% devo verificare l'indervallo di confidenza al 95%

%   A(z) = 1 - 1.592 (+/- 0.04061) z^-1 + 0.5923 (+/- 0.04063) z^-2                                                                                                                                                                                                                                                                
% 
%   B1(z) = 0.0006351 (+/- 9.95e-05)                                                                                                                                                                                                                                                                                               
% 
%   B2(z) = 0  

[- 1.592-2*0.04061;- 1.592+2*0.04061]
[0.5923-2*0.04063;0.5923+2*0.04063]
[0.0006351-2*9.95e-05;0.0006351+2*9.95e-05]



%         ans =
% 
%    -1.6732
%    -1.5108
% 
% 
% ans =
% 
%     0.5110
%     0.6736
% 
% 
% ans =
% 
%    1.0e-03 *
% 
%     0.4361
%     0.8341

% non ci sono cambi di segno quindi scarto l'ipotesi nulla con una
% probabilità del 95% per ogni parametro
