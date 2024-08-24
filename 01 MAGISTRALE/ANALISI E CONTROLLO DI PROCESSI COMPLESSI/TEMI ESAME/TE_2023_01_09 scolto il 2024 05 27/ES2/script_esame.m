clear all

numberOfVariables = 3; %[alfa, K4(1), K4(2)] in ordine
opts =optimoptions(@ga);
opts.UseParallel=true; 
opts.Display='iter';
opts.PopulationSize=10;
opts.MaxTime=150; 

% 0.3*K4(1)+0.2*K4(2)<3 => 0*a +0.3*K4(1)+0.2*K4(2)<3
% Ad+x <=Bd
% Ad avrà tante colonne quante solo le righe di x
% x avrà tante righe quante solo le varaibili
% Ad tante righe quanti sono i vincoli, ogni colonna un coefficiente delle
% variabili che voglio ottimizzare per quel vincolo
Ad=[0 0.3 0.2]; % in questo caso 1 riga perchè ho un solo vincolo
Bd=3;% valore a destra disuguaglianza
Ae=[];
Be=[];
lb =[-inf,0,0.1];% non abbiamo lb per alfa
ub =[+inf,1,0.5];% non abbiamo ub per alfa

%ora dobbiamo definire la funzione obiettivo ( altro script)
[Kga,fval,Output] = ga(@(K) fobj_esame(K,0),numberOfVariables,Ad,Bd,Ae,Be,lb,ub,[],opts);
fobj_GA=fobj_esame(Kga,1);
