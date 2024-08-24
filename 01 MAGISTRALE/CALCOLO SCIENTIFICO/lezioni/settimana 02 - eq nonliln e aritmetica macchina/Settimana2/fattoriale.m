function [f]=fattoriale(n)
% calcolo del fattoriale di un numero intero
% istruzione di chiamata: f=fattoriale(n)
% input: n = numero intero
% output: f= n!

if n <0 
    f=[]; 
    disp('n è negativo, non posso calcolare n!')
elseif n==0
    f=1;
else
    f=prod(1:n);
end

end