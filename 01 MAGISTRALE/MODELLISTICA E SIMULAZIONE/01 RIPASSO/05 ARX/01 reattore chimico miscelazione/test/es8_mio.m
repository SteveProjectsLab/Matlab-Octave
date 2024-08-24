clear
close all
clc


% Si vuole progettare un modello arx per la risoluzione di un
% problema di previsione fino a 30 secondi della concentrazione di
% prodotto sviluppata da un reattore chimico a miscelazione continua.


% Il sistema prevede l’immissione di reagenti (controllabile) nel
% serbatoio e una “pala” che permette di mescolare la miscela al fine
% di ottenere dei prodotti di reazione.

% Sul sistema NON si possono fare test, ma sono disponibili dei dati,
% campionati ogni 6 secondi. 
% 
% I dati, tutti validi, sono contenuti nel file
% cstr.mat che contiene anche delle brevi descrizioni delle variabili.


% Il sistema ha un memoria massima di 18 secondi sia per quanto
% riguarda l’uscita che per quanto riguarda gli ingressi. 
% 
% Non c è  motivo di supporre ritardo tra uscita e ingressi.

% Si vuole determinare, in queste condizioni e utilizzando 6000 dati
% per la identificazione e i restanti per la validazione, il modello arx
% migliore per il problema in esame come rapporto complessità/
% prestazioni.


load 'MODELLISTICA E SIMULAZIONE'\'01 RIPASSO'\'05 ARX'\'01 reattore chimico miscelazione'\cstr.mat

%Tc=6;                       %secondi
memoria_max=18              %secondi

dati=iddata(Y(:,1),U,Tc);
dati_val=dati(1:6000);
dati_id=dati(6001:end)

na_max=memoria_max/Tc;      %ordine auto regressiva
nb_max=memoria_max/Tc;      %ordine esogena
nk=0;                       %ritardo

orizzonte_previsione=30/Tc     %secondi

i=0;
for iar=1:na_max
    for iex=0:nb_max
        i=i+1;
        orders=[iar iex nk];
        modello=arx(dati_id,orders);
        dati_out=predict(modello,dati_id,orizzonte_previsione);
        lista_modelli{i}=modello;
        struc(i,:)=orders;
        e=dati_out.y-dati_id.y;
        d=iar+iex;
        L=length(dati_id.y);
        FPE(i)=e'*e/L*(1+d/L)/(1-d/L);
    end
end

[fpe_min,imin]=min(FPE)
best_model=lista_modelli{imin};
present(best_model)

% best_model =                                                                                                                                                                                                                                                                                                                     
% Discrete-time ARX model: A(z)y(t) = B(z)u(t) + e(t)                                                                                                                                                                                                                                                                              
% 
%   A(z) = 1 - 2.765 (+/- 0.0067) z^-1 + 2.621 (+/- 0.01315) z^-2                                                                                                                                                                                                                                                                  
%                                      - 0.8558 (+/- 0.00666) z^-3                                                                                                                                                                                                                                                                 
% 
% 
%   B(z) = -7.858e-07 (+/- 3.049e-06) + 0.0002094 (+/- 4.298e-06) z^                                                                                                                                                                                                                                                               
%                              -1 - 0.0002086 (+/- 3.068e-06) z^-2                                                                                                                                                                                                                                                                 
% 
% Sample time: 6 seconds                                                                                                                                                                                                                                                                                                           
% 
% Parameterization:                                                                                                                                                                                                                                                                                                                
%    Polynomial orders:   na=3   nb=3   nk=0                                                                                                                                                                                                                                                                                       
%    Number of free coefficients: 6                                                                                                                                                                                                                                                                                                
%    Use "polydata", "getpvec", "getcov" for parameters and their uncertainties.                                                                                                                                                                                                                                                   
% 
% Status:                                                                                                                                                                                                                                                                                                                          
% Estimated using ARX on time domain data "dati_id".                                                                                                                                                                                                                                                                               
% Fit to estimation data: 99.46% (prediction focus)                                                                                                                                                                                                                                                                                
% FPE: 7.509e-09, MSE: 7.419e-09                                                                                                                                                                                                                                                                                                   
% More information in model's "Report" property.                                                                                                                                                                                                                                                                                   


% faccio la validazione
% a questo punto faccio la validazione (non era richiesta dall'esercizio, uso NME, NMAE, CORR)
fprintf('validazione\n')
dati_out_val=predict(best_model,dati_val,orizzonte_previsione);
e_val=dati_out_val.y-dati_val.y;
NME=mean(e_val)/mean(dati_val.y)
NMAE=mean(abs(e_val))/mean(dati_val.y)
CORR=corrcoef(dati_out_val.y,dati_val.y);
CORR=CORR(2,1)

fprintf('simulazione\n')
% come si comporta il sistema in simulazione?
dati_out_val_sim=sim(best_model,dati_val);
e_val=dati_out_val_sim.y-dati_val.y;
NME_sim=mean(e_val)/mean(dati_val.y)
NMAE_sim=mean(abs(e_val))/mean(dati_val.y)
CORR_sim=corrcoef(dati_out_val_sim.y,dati_val.y);
CORR_sim=CORR_sim(2,1)



