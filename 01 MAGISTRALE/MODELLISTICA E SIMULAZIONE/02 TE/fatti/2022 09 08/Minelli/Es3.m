clear
close all
clc

%Es.3

load climate.mat;
Y=climate(:,3);
U=climate(:,1:2);
T=1;
dati=iddata(Y,U,T);
n_dati_id=400;
dati_id=dati(1:n_dati_id);
dati_val=dati(n_dati_id+1:end);
na_max=2;
nb_max=2;
nk=[0 0];

MAE=[];
corr=[];
i=0;

%Calcolo i modelli possibili
for iar=1:na_max
    for ies1=0:nb_max
        for ies2=0:nb_max
            i=i+1;
            na=iar;
            nb=[ies1 ies2];
            mod=arx(dati_id,[na nb nk]);
            lista_mod{i}=mod;
            dati_sim=sim(mod,dati_val);
            e=dati_sim.y-dati_val.y;
            MAE(i)=mean(abs(e));
            c=corrcoef(dati_sim.y,dati_val.y);
            corr(i)=c(2,1);
        end
    end
end

%Scelgo il modello migliore in base al MAE
[MAE_best,i_best]=min(MAE);
modello_best=lista_mod{i_best};
corr_best=corr(i_best);
fprintf('Modello migliore:\n')
present(modello_best);
fprintf('MAE: %f\t Correlazione: %f\n\n',MAE_best,corr_best);
fprintf('Intervalli di confidenza richiesti dei parametri stimati:\n');
fprintf('\tMoltiplicatore z^-1 parte AR: [%f,%f]\n',-1.628-(2*0.03884),-1.628+(2*0.03884));
fprintf('\tMoltiplicatore z^-2 parte AR: [%f,%f]\n',0.629-(2*0.03874),0.629+(2*0.03874));
fprintf('\tMoltiplicatore z^0 ingresso 2: [%e,%e]\n',2.535e-5-(2*4.415e-6),2.535e-5+(2*4.415e-6));