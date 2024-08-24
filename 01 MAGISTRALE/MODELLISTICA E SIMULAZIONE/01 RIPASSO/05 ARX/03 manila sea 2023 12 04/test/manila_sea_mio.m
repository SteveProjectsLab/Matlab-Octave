clear all
clc

load 'MODELLISTICA E SIMULAZIONE'\'01 RIPASSO'\'05 ARX'\'03 manila sea 2023 12 04'\test\manila_sea.mat

% si vuole prevedere l'andamento del livello delle acque nel golfo di
% Manila in funzione dell'anomalia di temperatura.
% Si hanno a disposizione i data mensili di livello del mare ( sealevel e
% di anomalia di temperatura (ta).

% l'impatto dell'anomalia di temperatura si inizia a vedere dopo un anno
% sul livello del mare
% si vuole mantenere un modello che abbia al massimo na=2 e nb=3

% si vuole utilizzare il modello identificato per prevedere il valore del
% livelo del mare con un anticipo almeno annuale per poter prendere delle
% contromisure adeguate.

% considero una soglia di correlazione di 0.6 come soglia di accettabilità
% delle prestazioni
% quanti anni di anticipo posso fare adeguatamente le previsioni?

u=ta
y=sealev
Tc=1;

data=iddata(y,u,Tc);
id_data=data(1:170);        %dataset identificazione
val_data=data(171:end);     %dataset validazione

na=2;
nb=3;
nk=12;              %mesi di ritardo, ovvero un anno
horizon=12;         %orizzonte di previsione

orders=[na nb nk];
model=arx(id_data,orders);
y_val=predict(model,val_data);
e=y_val.y-val_data.y;
MAE=mean(abs(e));
c_val=corrcoef(y_val.y,val_data.y);
correlation_val=c_val(2,1);

fprintf('MAE del modello:\n%f',MAE);
present(model);
fprintf('correlazione:%f',correlation_val);

% MAE del modello:
% 0.022783
% 
% model =                                                                                                                                                                                                                                                                                                 
% Discrete-time ARX model: A(z)y(t) = B(z)u(t) + e(t)                                                                                                                                                                                                                                                     
% 
%   A(z) = 1 - 0.8728 (+/- 0.07791) z^-1 - 0.04909 (+/- 0.07928) z^-2                                                                                                                                                                                                                                     
% 
% 
%   B(z) = -0.001426 (+/- 0.006728) z^-12 - 0.004366 (+/- 0.007241) z^-13                                                                                                                                                                                                                                 
%                                   + 0.01477 (+/- 0.006592) z^-14                                                                                                                                                                                                                                        
% 
% Sample time: 1 seconds                                                                                                                                                                                                                                                                                  
% 
% Parameterization:                                                                                                                                                                                                                                                                                       
%    Polynomial orders:   na=2   nb=3   nk=12                                                                                                                                                                                                                                                             
%    Number of free coefficients: 5                                                                                                                                                                                                                                                                       
%    Use "polydata", "getpvec", "getcov" for parameters and their uncertainties.                                                                                                                                                                                                                          
% 
% Status:                                                                                                                                                                                                                                                                                                 
% Estimated using ARX on time domain data "id_data".                                                                                                                                                                                                                                                      
% Fit to estimation data: 45.16% (prediction focus)                                                                                                                                                                                                                                                       
% FPE: 0.001309, MSE: 0.001191                                                                                                                                                                                                                                                                            
% More information in model's "Report" property.                                                                                                                                                                                                                                                          
% 
% Model Properties
% correlazione:0.783996>> 


% punto b
% previsione a 1 anno ( 12 mesi)
y_val_12=predict(model,val_data,horizon);
c_val_12=corrcoef(y_val_12.y,val_data.y);
correlation_12=c_val_12(2,1)

% correlation_12 =
% 
%     0.6437        ok

% previsione a 2 anno ( 24 mesi)
y_val_24=predict(model,val_data,2*horizon);
c_val_24=corrcoef(y_val_24.y,val_data.y);
correlation_24=c_val_24(2,1)

% correlation_24 =
% 
%     0.5026        NB è sotto soglia!!

% (non era richiesto) considero l'incertezza dei parametri, 95% ( 2 sigma)

% 0.8728 (+/- 0.07791) z^-1 
% - 0.04909 (+/- 0.07928) z^-2                                                                                                                                                                                                                                     
% -0.001426 (+/- 0.006728) z^-12 
% - 0.004366 (+/- 0.007241) z^-13 
% + 0.01477 (+/- 0.006592) z^-14    

int_conf_par1=[-0.8728-2*0.07791,-0.8728+2*0.07791]
int_conf_par2=[- 0.04909-2*0.07928,- 0.04909+2*0.07928]         %
int_conf_par3=[-0.001426-2*0.006728,-0.001426+2*0.006728]       %
int_conf_par4=[- 0.004366-2*0.007241,- 0.004366+2*0.007241]     %
int_conf_par5=[+ 0.01477-2*0.006592,+ 0.01477+2*0.006592]

% int_conf_par1 = -1.0286   -0.7170         posso rifiutare l'ip nulla con 95% di confidenza
% int_conf_par2 = -0.2077    0.1095          ATTENZIONE c'è l'ipotesi nulla
% int_conf_par3 = -0.0149    0.0120          ATTENZIONE c'è l'ipotesi nulla
% int_conf_par4 = -0.0188    0.0101          ATTENZIONE c'è l'ipotesi nulla
% int_conf_par5 = 0.0016    0.0280          posso rifiutare l'ip nulla con 95% di confidenza