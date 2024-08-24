clear
close all
clc

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

%input manipolabili:
%p1: variando il valore di p1 è possibile variare direttamente la dinamica
    %dei granchi nel laghetto
%a1 e a2: modificando i coefficienti di incontro tra le due specie è
         %possibile modificare la dinamica delle due specie
%input non manipolabili:
%tau: il parametro è una caratteristica della specie degli squali

fprintf('Es.1\n\n');
fprintf('Modello:\n');
fprintf('\tdX1/dt=%s\n\tdX2/dt=%s\n\n',F(1),F(2));
fprintf('Variabili di stato:\n');
fprintf('\tX1: numero di crostacei\n');
fprintf('\tX2: numero di squali\n');
fprintf('Ingressi:\n');
fprintf('\tp1: pesca dei crostacei\n');
fprintf('Uscite:\n');
fprintf('\ty1: numero di crostacei (coincide con X1)\n');
fprintf('\ty2: numero di squali (coincide con X2)\n');
fprintf('Input manipolabili:\n');
fprintf('\tp1: variando il suo valore si modifica direttamente la dinamica dei crostacei\n');
fprintf(['\ta1 e a2: variando i coefficienti di incontro tra le due specie è possibile\n' ...
    '\tmodificare la dinamica di entrambe le specie (ad esempio limitando il numero di crostacei\n' ...
    '\te di squali che possono essere nella stessa zona del laghetto si riducono a1 e a2)\n']);
fprintf('Input non manipolabili:\n');
fprintf('\ttau: il parametro è una caratteristica della specie degli squali\n');
