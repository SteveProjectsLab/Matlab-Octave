syms X1 X2

k=0% capacità portante
a1=0 %prob incontro crostacei
a2=0 %prob incontro squali 
p1=0 % diminuzione di velocità dovuta alla pesca
tau=0 %coefficiente mortalità


f=[X1-X1^2/k-a1*X1*X2-p1,-tau*X2+a2*X1*X2];

% var stato X1,X2
% uscite derivate
% ingressi manipolabili p1
% ingresi non manipolabili tau, 
% a1, a2 dipende