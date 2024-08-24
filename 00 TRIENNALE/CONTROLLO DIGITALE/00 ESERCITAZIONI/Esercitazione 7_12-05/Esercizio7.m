clear 
close all
clc

%%
%Definisco Sistema

num= 1;
den= conv([1 1], [1 1]);

G=tf(num, den);

%%
%Tempo Campionamento

Tc= 2*pi/ 500;

%%
%Sottosistema analogico

Gzoh= tf(1, [0.5*Tc 1]);

Ga= G*Gzoh;

%Poi vado su sisotool(Ga) e modfifico C, come indicato in SPIEGAZIONE

%Dopo aver creato il controllore, clicco su Export ed esporto C

%MA: esporta in zpk, quindi lo converto in tf
% digito in command window C=tf(C)

%Salvo C: save C_file C

%%
%Lavoro su C, quindi eseguo load C_file
% Lo voglio discretizzare

load myC_file

C_d= c2d(C, Tc, 'tustin');

%%
%Poi apro simulink
%Creo transfer function, con G !

%Perchè è G che voglio controllare

%cell2mat(G.num)
%cell2mat(G.den)

% Poi:
% 
% metto il controllore a tempo discreto:
% Discrete Transfer Function, con 
% cell2mat(C_d.num)
% cell2mat(C_d.den)
% Tc


%Poi metto retroazione +-

%Scalino

%Uscita

%%
%Domanda in più:

% Cosa succcede se dopo aver progettato il controllore,
% sulla scheda di acquisiszione c'è un TC=0.1?
% Valutare impatto sulla prestazioni in tempo di risposta, sovraelongazione ed errore a regime

%Aggiungo un altro schema simulink in cui uso Tc=0.1, nella 
%Discrete transfer function

%Si nota che il sistema controllatoc on Tc= 0.1, non garantisce la
%stabililtà in anello chiuso

%[ infatti non va a un valore stabile,ma diverge]
