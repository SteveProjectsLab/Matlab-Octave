load 'MODELLISTICA E SIMULAZIONE'\'ese_09_2023_11_21 - ARX'\es7_dati.mat
dati=iddata(y,u);
na=1;nb=1;nk=0;
orders=[na nb nk];
modello =arx(dati, orders)
ypred=predict(modello,dati)
y_v=ypred.y;

e=ypred.y-y_v