function xq = myQuant(x,bits)

D = max(x)-min(x); % dinamica
xres = x-min(x); % residuo

% Versione con divisione

delta = D/2^bits;
xq = delta*(floor(xres/delta)+1/2);
xq = xq+min(x);%-delta*(xq==max(xq)); % Annullo lo spike per i massimi

% Versione con bisezione

% inizializzo xq al primo valore di ricostruzione
% xq = ones(size(x))*min(x)+D/2^(bits+1); 
% 
% for b = 1:bits % bisezione, MSB->LSB
%     thisbit = (xres>D/2^b);
%     xq = xq+thisbit*D*2^(-b);
%     xres = xres-thisbit*D/2^b;
% end
% 
% 
