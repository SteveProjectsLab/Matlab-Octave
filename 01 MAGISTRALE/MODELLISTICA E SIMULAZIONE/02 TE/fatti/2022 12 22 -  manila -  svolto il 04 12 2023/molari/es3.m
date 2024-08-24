close
clear all
clc
%-------------------------------------------------------------------------
% punto a
%-------------------------------------------------------------------------
% quanto il riscaldamento globale impatta, mese per mese, sul livello del
% mare a manila

load manila_sea

dati=iddata(sealev,ta);
dati_id=dati(1:170);
dati_val=dati(170:end);

% ARX(2,3) e ritardo 12

na=2;
nb=3;
nk=12;

modello=arx(dati_id,[na nb nk])
dati_sim_val=predict(modello,dati_val);
e=dati_sim_val.y-dati_val.y;
mae_val=mean(abs(e))
corr_val=corrcoef(dati_sim_val.y,dati_val.y);
corr_val=corr_val(2,1)

% modello =
% Discrete-time ARX model: A(z)y(t) = B(z)u(t) + e(t)      
%   A(z) = 1 - 0.8728 z^-1 - 0.04909 z^-2                  
% 
%   B(z) = -0.001426 z^-12 - 0.004366 z^-13 + 0.01477 z^-14

% mae_val =
% 
%     0.0230
% 
% 
% corr_val =
% 
%     0.7926

%-------------------------------------------------------------------------
% punto b
%-------------------------------------------------------------------------
dati_sim_test12=predict(modello,dati_val,12);% passo 12
corr_test12=corrcoef(dati_sim_test12.y,dati_val.y);
corr_test12=corr_test12(2,1)

dati_sim_test24=predict(modello,dati_val,24);% passo 12
corr_test24=corrcoef(dati_sim_test24.y,dati_val.y);
corr_test24=corr_test24(2,1)


% corr_test12 =
% 
%     0.6484
% 
% 
% corr_test24 =
% 
%     0.4858

%-------------------------------------------------------------------------
% extra
%-------------------------------------------------------------------------
% per avere più informazioni usa present(modello)

% consideriamo il primo coefficiente della parte autoregrezsiva
% ha deviazione standard di circa 0,08
% moltiplico per due
% se sommo o sottraggo a -0,87 quel parametro non cambia segno

% non contiene lo zero, rifiuto l'ipotesi nulla con una confideza del 95%


% riguarda video per considerazioni finali
