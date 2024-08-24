clear all
load 'MODELLISTICA E SIMULAZIONE'\'01 RIPASSO'\'05 ARX'\intro\es7_dati.mat

% in matlab esiste il comando arx che identifica (=calcola theta, vettore
% dei parametri) il modello una volta fissati gli ordini, i ritardi, e il
% dataset
dati=iddata(y,u);

na=1;
nb=1;
nk=0;
orders=[na,nb,nk];

% il comando arx "usa" il dataset in un formato che si chiama iddata,
% quindi per prima cosa dobbiamo definire il dataset in questa forma (nota:
% u e y letti dal file .mat sono in forma vettoriale)

mod110=arx(dati,orders)

% mod110 =
% Discrete-time ARX model: A(z)y(t) = B(z)u(t) + e(t)
%   A(z) = 1 - 0.7722 z^-1                           
%                                                    
%   B(z) = 0.002313  

% A(z)y(t) = B(z)u(t) => (1-0.7722z^-1)y(t)=0.002313*u(t)
% y(t)-0.7722z^-1*y(t)=0.002313*u(t)
% z^-i è l'operatore di traslazione che trasla y(t) in y(t-i)
% y(t)-0.7722*y(t-1)=0.002313*u(t)
% y(t)=0.7722*y(t-1)+0.002313*u(t)
% il modello nel tempo risulta: y(t)=0.7722*y(t-1)+0.002313*u(t)

ypred=predict(mod110,dati) % calcola i dati di output del modello IN PREVISIONE

% ypred ha formato iddata, per avere il vettore delle uscite del modello 
% devo prendere il campo y di ypred=>ypred.y (ps. analogo per la variabile
% dati)
ypred_v=ypred.y;
y_v=dati.y; % (=y letto dal file .mat)

% ypred_v e y_v sono le uscite del sistema e la misura di y in formato
% vettoriale
e=ypred_v-y_v;
ME=mean(e)
MAE=mean(abs(e))
NME=ME/mean(y_v)
NMAE=MAE/mean(y_v)
corr=corrcoef(ypred_v,y_v)
corr=corr(2,1)






