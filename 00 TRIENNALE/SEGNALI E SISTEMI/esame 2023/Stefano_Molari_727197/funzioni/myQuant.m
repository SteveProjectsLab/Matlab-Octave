function xq = myQuant(x,bits)

%VARIABILI
% x = segnale
% bits = numero di bit, livelli di quantizzazione

%COSA FA 
% quantizza il segnale

D = max(x)-min(x);  % dinamica
xres = x-min(x);    % residuo
% far si che l'estremo inferiore sia zero

% Versione con divisione
L=2^bits;    % numero di livelli
delta = D/L;
xq = delta*(floor(xres/delta)+1/2); % segnale quantizzato
xq = xq+min(x)-delta*(xq==max(xq)); % annullo lo spike per i massimi