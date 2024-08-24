function [f] = fattoriale(n)
%calcola il fattoriale di un numero intero
%   input: n = numero intero
%   output: f=n!

if n<0
    f=[];
    disp('n è negativo non esiste il fattoriale')
elseif n==0
        f=1;
else
    f=prod(1:n);
end