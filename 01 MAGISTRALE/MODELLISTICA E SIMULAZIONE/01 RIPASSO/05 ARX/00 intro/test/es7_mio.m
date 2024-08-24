% Il file es7_dati contiene le variabili y e u che contengono
% rispettivamente i valori dell’ingresso e dell’uscita di un sistema
% sconosciuto.
% Si chiede di identificare e valutare le prestazioni dei modelli seguenti,
% considerati sia in previsione:
clear
close all
clc

load 'MODELLISTICA E SIMULAZIONE'\'01 RIPASSO'\'05 ARX'\'00 intro'\test\es7_dati.mat

dati=iddata(y,u);

modello110=arx(dati,[1 1 0]);
present (modello110)

modello111=arx(dati,[1 1 1]);
present (modello111)

modello210=arx(dati,[2 1 0]);
present (modello210)

modello120=arx(dati,[1 2 0]);
present (modello120)

%calcolo i dati in previsione
data_out110=predict(modello110,dati) 
data_out111=predict(modello111,dati)
data_out210=predict(modello210,dati)
data_out120=predict(modello120,dati)

% facoltativo
t=0:1:length(dati.y)-1;
plot(t,dati.u/100)
hold on
plot(t,dati.y)
hold on
pause

plot(t,data_out110.y)
hold on
pause

plot(t,data_out111.y)
hold on
pause

plot(t,data_out210.y)
hold on
pause

plot(t,data_out120.y)
hold on
pause

legend('u','y','y110','y111','y210','y120');
fprintf('arx(110)\n')
e110=data_out110.y-dati.y;
ME110=mean(e110)
MAE110=mean(abs(e110))
NME110=ME110/mean(dati.y)
NMAE110=MAE110/mean(dati.y)
c=corrcoef(data_out110.y,dati.y)
corr110=c(2,1)

fprintf('arx(111)\n')
e111=data_out111.y-dati.y;
ME111=mean(e111)
MAE111=mean(abs(e111))
NME111=ME111/mean(dati.y)
NMAE111=MAE111/mean(dati.y)
c=corrcoef(data_out111.y,dati.y)
corr111=c(2,1)

fprintf('arx(210)\n')
e210=data_out210.y-dati.y;
ME210=mean(e210)
MAE210=mean(abs(e210))
NME210=ME210/mean(dati.y)
NMAE210=MAE210/mean(dati.y)
c=corrcoef(data_out210.y,dati.y)
corr210=c(2,1)

fprintf('arx(120)\n')
e120=data_out120.y-dati.y;
ME120=mean(e120)
MAE120=mean(abs(e120))
NME120=ME120/mean(dati.y)
NMAE120=MAE120/mean(dati.y)
c=corrcoef(data_out120.y,dati.y)
corr120=c(2,1)