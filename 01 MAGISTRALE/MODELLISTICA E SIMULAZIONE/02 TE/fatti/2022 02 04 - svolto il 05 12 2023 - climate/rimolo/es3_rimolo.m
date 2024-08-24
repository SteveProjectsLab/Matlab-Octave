clear all
clc
load 'MODELLISTICA E SIMULAZIONE'\'02 TE'\fatti\'2022 02 04 - svolto il 05 12 2023 - climate'\rimolo\climate.mat
y=climate(:,3);
u=climate(:,1:2);
dati=iddata(y,u);

dati_id=dati(1:400); % dataset di identificazione
dati_val=dati(401:end); % datset di validazione
max_ord_ar=2;
max_ord_ex=2;
rit=0;
cont=0;
for iar=1:max_ord_ar
for iex=1:max_ord_ex
cont=cont+1;
na=iar;%[iar iar];
nb=[iex iex];
nk=[rit rit];
modello=arx(dati_id,[na,nb,nk]);
lista_modelli{cont}=modello;
struttura(cont,:)=[na,nb,nk];
% devo selezionare il modello migliore considerando il MAE
dati_out_id=sim(modello,dati_id);
e=dati_out_id.y-dati_id.y;
MAE(cont)=mean(abs(e));
end
end