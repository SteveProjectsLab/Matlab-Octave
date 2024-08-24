clear
close all
clc

%Es.3
load manila_river.mat
y=portata;
u=precip;
T_camp=1;   %in mesi
dati=iddata(y,u,T_camp);
%suddivisione dataset
n_dati_id=180;
dati_id=dati(1:n_dati_id);
dati_val=dati(n_dati_id+1:end);

na_max=2;
nb_max=2;
nk=0;

or_previsione1=T_camp;      %previsione a un mese
or_previsione3=3*T_camp;    %previsione a tre mesi

i=0;
MAE_1m=[];
corr_1m=[];

%calcolo tutti i possibili modelli
for iar=1:na_max
    for ies=0:nb_max
        i=i+1;
        struct=[iar ies nk];
        modello=arx(dati_id,struct);
        struttura{i}=struct;
        lista_mod{i}=modello;
        dati_1m=predict(modello,dati_val,or_previsione1);
        e_1m=dati_1m.y-dati_val.y;
        MAE_1m(i)=mean(abs(e_1m));
        c_1m=corrcoef(dati_1m.y,dati_val.y);
        corr_1m(i)=c_1m(2,1);
        %calcolo dei parametri per i modelli a 3 mesi (non usati nella
        %scelta del modello migliore, ma per lo studio dell'impatto 
        % dell'ingresso sull'uscita)
        dati_3m=predict(modello,dati_val,or_previsione3);
        e_3m=dati_3m.y-dati_val.y;
        MAE_3m(i)=mean(abs(e_3m));
        c_3m=corrcoef(dati_3m.y,dati_val.y);
        corr_3m(i)=c_3m(2,1);
    end
end

[MAE_best_1m,i_best]=min(MAE_1m);
modello_best=lista_mod{i_best};
present(modello_best);
corr_best_1m=corr_1m(i_best);
MAE_best_3m=MAE_3m(i_best);
corr_best_3m=corr_3m(i_best);

% modello migliore:                                                               
% Discrete-time ARX model: A(z)y(t) = B(z)u(t) + e(t)                           
%   A(z) = 1 - 0.149 (+/- 0.0612) z^-1 + 0.02792 (+/- 0.05059) z^-2             
%                                                                               
%   B(z) = 0.5966 (+/- 0.03976)   
%   na=2   nb=1   nk=0

%prestazioni in previsione a un mese:
%MAE: 2.0889
%Correlazione: 0.9220

%prestazioni in previsione a tre mesi:
%MAE: 2.2170
%Correlazione: 0.9185

%Valuto l'impatto dell'ingresso
%Prestazioni dei modelli senza precipitazioni (1 mese)
MAE_1m_noIn=[MAE_1m(1);MAE_1m(4)];
[MAE_noInput_best_1m,i_noInputBest]=min(MAE_1m_noIn);
corr_noInput_best_1m=corr_1m(i_noInputBest);

%Prestazioni dei modelli senza precipitazioni (3 mesi)
MAE_3m_noIn=[MAE_3m(1);MAE_3m(4)];
[MAE_noInput_best_3m,i_noInputBest]=min(MAE_3m_noIn);
corr_noInput_best_3m=corr_3m(i_noInputBest);

%Prestazioni senza ingressi:
%Previsione a un mese
%Miglior MAE senza ingresso: 3.4019
%Correlazione associata senza ingresso: 0.6634

%Previsione a tre mesi
%Miglior MAE senza ingresso: 5.4076
%Correlazione associata senza ingresso: -0.0298

%in entrambi i casi di previsione gli ingressi impattano molto sulle
%prestazioni del modello, in quanto i MAE aumentano e le correlazioni
%diminuiscono notevolmente