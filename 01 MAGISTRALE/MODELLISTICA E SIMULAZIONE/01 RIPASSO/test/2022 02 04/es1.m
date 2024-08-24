clear all
clc

% La Laghetti Estremi SpA vi commissiona la modellizzazione della evoluzione 
% di due specie in uno dei suoi laghi per la pesca sportiva, 
% contenente squali e crostacei. 
% Le informazioni fornite in merito al process sono le seguenti:
% • Il sistema `e da considerarsi a tempo continuo.
% • Quando i crostacei (x1) erano da soli nel lago, 
% la loro dinamica era ben rappresentata da una velocità di variazione istantanea 
% nel tempo che era data dalla somma di 2 componenti:
    % – la prima era rappresentabile attraverso una curva logistica, 
    % avente asintoto orizzontale K;
    % – la seconda rappresentava la variazione dovuta alla pesca, 
    % che causava una diminuzione di velocità costante pari p1;
% • Se considerati da soli, gli squali (x2) tendevano a estinguersi 
%   con velocit`a proporzionale alla loro quantit`a (coefficiente τ );
% • Quando gli squali vengono messi nello stesso laghetto dei crostacei 
% le due dinamiche vengono influenzate da un addendo proporzionale 
% alla probabilit`a di incontro tra le due specie (coefficiente α1 per crostacei e
% α2 per gli squali).
% • Considerare tutti i parametri K, α1, α2 e p1 positivi e quindi rendere esplicito il segno del loro impatto
% nella modellizzazione.

%Es1
syms X1 X2 p1 K tau a1 a2;

%Variabili di stato:
%X1: crostacei (variabile di stato)
%X2: squali (variabile di stato)
%ingressi:
%p1: pesca (ingresso)
%uscite:
%y1: numero di granchi nel laghetto
%y1: numero di squali nel laghetto
%parametri
%K: capacità portante
%tau: coefficiente mortalità squali
%a1: coefficiente incontro granchi-squali (per granchi)
%a2: coefficiente incontro granchi-squali (per squali)

F=[X1-X1^2/K-p1-a1*X1*X2;-tau*X2+a2*X1*X2];
y1=X1;
y2=X2;