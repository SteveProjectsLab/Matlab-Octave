% La ditta Carnevale&C. vi commissiona la modellizzazione della produzione e della vendita di un prodotto a
% partire da una certa materia prima. Le informazioni fornite in merito al process sono le seguenti:
% • Il sistema `e da considerarsi a tempo discreto.
% • A fronte di una quantit`a di risorsa r in ingresso al tempo t si ha una variazione del semilavorato p1 di
% α · r dal tempo t al tempo t + 1;
% • Da una quantit`a di semilavorato p1 al tempo t si ottiene una quantit`a di prodotto di alta qualit`a p2 pari
% a β · p1 al tempo t + 1 e una quantit`a (1 − β) · p1 di prodotto di bassa qualit`a p3 al tempo t + 1;
% • il prodotto di alta qualit`a potr`a essere immesso sul mercato al prezzo unitario di 10, mentre quello di
% bassa qualit`a al prezzo unitario di 3.

p1(t+1)=alpha*r(t)*p1(t);
p2(t+1)=beta*p1(t);
p3(t+1)=(1-beta)*p1(t);

% Variabili di stato:
% p1 -> quantità di semilavorato al tempo t
% p2 -> quantità di prodotto di alta qualità al tempo t
% p3 -> quantità di prodotto di bassa qualità al tempo t

% Uscite:
% - prezzo unitario del prodotto di alta qualità
% - prezzo unitario del prodotto di bassa qualità

% Ingressi manipolabili: r -> quanità di risorsa in ingresso
% Ingressi non manipolabili: alpha, beta -> non posso controllare la
% trasformazione di risorsa in prodotto e semilavorato