clear
close all
clc

%caricamento dei dati
load manila_sea.mat;
orizzonte_previsione=12;
dati=iddata(sealev,ta);
n_dati_id=170;
dati_id=dati(1:n_dati_id);
dati_val=dati(n_dati_id+1:end);

na_max=2;
nb_max=1;
nk=12;

i=0;
MAE=[];
corr=[];

%valutazione di tutti i possibili modelli
for iar=1:na_max
    for ies=0:nb_max
        i=i+1;
        na=iar;
        nb=ies;
        modello=arx(dati_id,[na nb nk]);
        lista_mod{i}=modello;
        dati_prev=predict(modello,dati_val,orizzonte_previsione);
        %calcolo dei parametri statistici
        e=dati_prev.y-dati_val.y;
        mae=mean(abs(e));
        c=corrcoef(dati_prev.y,dati_val.y);
        c=c(2,1);
        MAE(i)=mae;
        corr(i)=c;
    end
end

%scelta del modello migliore (quello con MAE minimo)
[MAE_best,i_best]=min(MAE);
modello_best=lista_mod{i_best};
corr_best=corr(i_best);
fprintf('Modello migliore:\n')
present(modello_best);
fprintf('MAE: %f\t Correlazione: %f\n\n',MAE_best,corr_best);

%effettuo previsioni annuali fino a che la correlazione è maggiore di 0.6
fprintf(['Valutazione delle prestazioni del modello con previsioni annuali:\n' ...
    'NB: Si accettano previsioni solo se i dati danno una correlazione superiore a 0.6\n']);
%previsione a un anno
dati_prev_1=predict(modello_best,dati_val,orizzonte_previsione);
MAE_1=mean(abs(dati_prev_1.y-dati_val.y));
corr_1=corrcoef(dati_prev_1.y,dati_val.y);
corr_1=corr_1(2,1);
fprintf('\tCorrelazione dopo un anno: %f\n',corr_1);

%previsione a due anno
dati_prev_2=predict(modello_best,dati_val,2*orizzonte_previsione);
MAE_2=mean(abs(dati_prev_2.y-dati_val.y));
corr_2=corrcoef(dati_prev_2.y,dati_val.y);
corr_2=corr_2(2,1);
fprintf('\tCorrelazione dopo due anni: %f\n',corr_2);
fprintf(['Il modello può effettuare previsioni distanti un solo anno dalla raccolta dei dati,\n' ...
    'in quanto la correlazione tra i dati previsti dopo due anni e quelli misurati scende\n' ...
    'al di sotto della soglia desiderata']);
