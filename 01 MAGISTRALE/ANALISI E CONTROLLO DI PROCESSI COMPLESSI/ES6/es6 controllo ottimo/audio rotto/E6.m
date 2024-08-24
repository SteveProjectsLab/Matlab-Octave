clear all
numberOfVariables = 3; % le due componenti di K e a
lb = [];
ub = [];
opts =optimoptions(@ga);% restituisce tutte le possibili configurazioni di default nell'algoritmo genetico
%ora sovrascrivo le configurazioni
opts.UseParallel=true; % usa il calcolo parallelo (usa tutti i core)
opts.Display='iter'; %generazione per generazione mostra il risultato
opts.PopulationSize=10; % quanti sono gli individui che di volta in volta vengono fatti evolvere nell'algoritmo
opts.MaxTime=150; % in secondi, tempo di evoluzione massimo
% nel nostro caso abbiamo 10 colonne e 10 righe , una per ogni individio
% della popolaizone
% più questa matrice diventa grande, più noi ci portiamo dietro..

%file_name=sprintf('%s_Pop_03d.mat',label_test,opts.PopulationSize);
%chiamata all'algoritmo genetico:
%[Kga,fval,Output] = ga(@(K) E6_fobj(K,0),numberOfVariables,[],[],[],[],lb,ub,[],opts);
%fobj_GA=E6_fobj(Kga,1);
% ottimizza rispetto a un qualcosa che io ho chiamato k, la fitness
% function che trovi nel file E6_fobj
% dopo number of variables, le prime due quadre sono i vincoli lineari di
% disuguaglianza o uguaglianza del tipo Adis*x<B dove x è il vettore delle
% variabili di decisione e Aeq*x=Beq
% esempio se avessi a+2*K1+8*K2<16 
% avrei un vincolod i diseguaglianza
% Ad=[1 2 8], Bd=[16]
% esempio2
% a+2*K1+8*K2<16 
% A-k1-3K2<10
%avrei
% % Ad=[1 2 8]; 1 -1 -3, Bd=[16;10]

% tante righe quanti sono i vincoli e tante colonne quante sono le
% variabili

% nel nostor caso non abbiamo vincoli nè di uguaglianza nè di
% disuguaglainza
Ad=[]
Bd=[]
Ae=[]
Be=[]

[Kga,fval,Output] = ga(@(K) E6_fobj(K,0),numberOfVariables,Ad,Bd,Ae,Be,lb,ub,[],opts);

% l'ultima coppia di parentesi quadre metterei se li avessi  i vincoli non
% lineari
% opts per dire all'algoritmo di lavorare con i miei valori di
% configurazione, quindi non con quelli di default

%come gran parte degli algoritmi di ottimizzazione generali, non di
%programmazione lineare o intera, abbiamo upper ground, lower bound ... ecc
%riascolta...


% opts =optimoptions('Particleswarm');
% opts.UseParallel=true;
% opts.Display='iter';
% opts.InitialSwarmSpan=2000;
% opts.MaxTime=1000;
% [xps,fval,Output] = particleswarm(@(x) E6_fobj(x,0),numberOfVariables,lb,ub,opts);
% fobj_PS=E7_fobj(xps,1);
% save(strcat(label_test,'_',file_name,'.mat'));