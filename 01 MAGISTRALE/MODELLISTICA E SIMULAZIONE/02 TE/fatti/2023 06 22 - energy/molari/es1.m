% Un virus ha inizialmente una dinamica tipica rappresentata da un modello SIR. A causa di una mutazione,
% la velocit`a di contagio diventa proporozionale al quadrato del prodotto tra gli infetti e i suscettibili, mentre la
% velocità di guarigione diventa proporzionale alla radice cubica degli infetti. Modellizzare la dinamica del virus
% mutato.
% è un sir normale
syms S I R
f=[d-b*(S*I)^2-m*S;
    b*(S*I)^2-g*I^(1/3)-m*I;
    g*I^(1/3)-m*R]

% variazione suscettibili
% variazione infetti
% variazione guariti
% uscite: S, I, R
% ingressi sistema: d nascite

% d: numero nascite
% b: probabilità incontro
% m: coefficente di mortalità
% g: tasso guarigione

% ingressi manipolabili: d,b,g
% ingress non manipolabili: m