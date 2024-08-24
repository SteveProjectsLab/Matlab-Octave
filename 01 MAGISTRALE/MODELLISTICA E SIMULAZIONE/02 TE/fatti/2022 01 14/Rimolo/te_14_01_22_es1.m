
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