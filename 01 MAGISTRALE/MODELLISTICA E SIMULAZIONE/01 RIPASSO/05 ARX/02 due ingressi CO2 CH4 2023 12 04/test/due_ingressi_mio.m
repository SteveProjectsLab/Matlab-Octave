clear all
clc
% Si vuole modellizzare l’impatto delle emissioni di CO2 e CH4 
% sull’anomalia di temperatura.

% (a) Scrivere uno script MATLAB che permetta di identificare e validare
% i modelli che legano emissioni e anomalia% di temperatura, tenendo conto che:

% • Il tempo di campionamento `e di 1 anno 
% e si vuole prevedere l’anomalia di temperatura fino a 3 anni.

% • I dati sono contenuti nel file climate.mat 
% (c1: emissioni di CO2; c2: emissioni di CH4, c3: anomalia di% temperatura)
% e sono TUTTI DATI VALIDI.

% • Non si conoscono ritardi apprezzabili 
% tra le variazioni degli ingressi e il loro impatto sull’uscita.

% • Si vuole mantenere un modello che abbia
% al massimo 2 coefficienti per la parte autoregressiva e 2 per gli% ingressi.

% • Si utilizzano 400 dati del dataset per l’identificazione (i primi) e i restanti la validazione.

% • Selezionare il modello migliore per il problema in esame sulla base del MAE.




% b) Presentare per il modello migliore:
% • la struttura del modello
% • le prestazioni sul dataset di validazione in termini di MAE e correlazione.
% • l’intervallo di confidenza al 95% dei parametri stimati


load 'MODELLISTICA E SIMULAZIONE'\'01 RIPASSO'\'05 ARX'\'02 due ingressi'\climate.mat
y=climate(:,3);
u=climate(:,1:2);

Tc=1;           %anno, tempo di campionamento
horizon=3;      %anni, orizzonte di previsione

data=iddata(y,u,Tc)
id_data=data(1:400);
val_data=data(401:end);

na_max=2;
nb_max=2;
nk=0;
i=0;
for iar=1:na_max
    for iex1=0:nb_max
        for iex2=0:nb_max
            i=i+1;
            orders=[iar,[iex1 iex2],[nk nk]];
            model=arx(id_data,orders);
            lista_modelli{i}=model;
            structure(i,:)=orders;
            y_prev_val=predict(model,val_data,horizon);
            e=y_prev_val.y-val_data.y;
            %ME(i)=mean(e(i));
            MAE(i)=mean(abs(e));
            %NME(i)=ME(i)/mean(id_data.y);
            %NMAE=MAE(i)/mean(id_data.y);
            c=corrcoef(y_prev_val.y,val_data.y);
            corr(i)=c(2,1);
        end
    end
end

[best_MAE_model_index,ibest]=min(MAE);
best_MAE_model=lista_modelli{ibest};
fprintf('IL MODELLO MIGLIORE:\n');
present(best_MAE_model)
fprintf('la correlazione vale:\n %f',corr(ibest));



% best_MAE_model =                                                                                                                                                                                                                                                                                                                                     
% Discrete-time ARX model: A(z)y(t) = B(z)u(t) + e(t)                                                                                                                                                                                                                                                                                                  
% 
%  A(z) = 1 - 1.592 (+/- 0.04061) z^-1 + 0.5923 (+/- 0.04063) z^-2                                                                                                                                                                                                                                                                                     
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
                                                   

% per l'intervallo di confidenz al 95%
%                   leggo dall'output

% NB ricordati di mettere il 2

% - 1.592 (+/- 2*0.04061)      per il primo parametro
%  0.5923 (+/- 2*0.04063)      per il secondo parametro
%  0.0006351 (+/- 2*9.95e-05)  per il terzo parametro

int1=[-1.592-2*0.04061,-1.592+2*0.04061]
int2=[0.5923-2*0.04063,0.5923+2*0.04063]
int3=[0.0006351-2*9.95e-05,0.0006351+2*9.95e-05]

% int1 =
%    -1.6732   -1.5108
% 
% int2 =
%     0.5110    0.6736
% 
% int3 =
%    1.0e-03 *
%     0.4361    0.8341

% il valore zero non è contenuto in nessun intervallo di confidenza
% quindi nessun parametro può essere nullo con una probabilità del 95%



