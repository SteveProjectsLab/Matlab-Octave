clear all
load manila_sea
dati=iddata(sealev,ta);
dati_id=dati(1:170);
dati_val=dati(171:end);

na=2;
nb=3;
nk=12;

modello=arx(dati_id,[na,nb,nk])
dati_sim_val=predict(modello,dati_val);
e=dati_sim_val.y-dati_val.y; % residui/errori
mae_val=mean(abs(e))
corr_val=corrcoef(dati_sim_val.y,dati_val.y);
corr_val=corr_val(2,1)

% modello =
% Discrete-time ARX model: A(z)y(t) = B(z)u(t) + e(t)
%                                                    
%   A(z) = 1 - 0.8728 z^-1                           
%           - 0.04909 z^-2                           
%                                                    
%                                                    
%   B(z) = -0.001426 z^-12                           
%           - 0.004366 z^-13                         
%          + 0.01477 z^-14     

% mae_val =
% 
%     0.0228
% 
% 
% corr_val =
% 
%     0.7840

% PUNTO (b)
dati_sim_test12=predict(modello,dati_val,12); % passo di previsione 12=1 anno (12 mesi)
corr_test12=corrcoef(dati_sim_test12.y,dati_val.y);
corr_test12=corr_test12(2,1)

dati_sim_test24=predict(modello,dati_val,24); % passo di previsione 12=1 anno (12 mesi)
corr_test24=corrcoef(dati_sim_test24.y,dati_val.y);
corr_test24=corr_test24(2,1)
% risulta


% Consideriamo l'incertezza sui parametri:
% HP nulla: il parametro potrebbe essere nullo
% livello di confidenza= 0.95 (95%)
% il comando present mi indica tra parentesi la deviazione
% standard del parametro stimato
% l'intervallo di confidenza a 0.95 è dato da 
% [valore_parametro-2*devstd_parametro;valore_parametro+2*devstd_parametro]
% coeff. AR z^-1: 
% valore parametro: -0.8728
% dev. std: 0.07791 (2*devstd=0.1558)
% int_conf95=[-0.8728-0.1558;-0.8728+0.1558]
% questo intervallo non contiene lo 0, quindi con attendibilità di 0.95
% posso dire che il parametro è diverso da 0 (posso RIFIUTARE HP nulla)


