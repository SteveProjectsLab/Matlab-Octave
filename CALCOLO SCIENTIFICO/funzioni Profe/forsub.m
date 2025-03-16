function [x]=forsub(L,b)
% forsub: risolve un sistema triangolare inferiore con il metodo di 
%sostituzioni in avanti (forward substitution)
%  [x]=forsub(L,b)
% Input: L matrice triangolare inferiore
%            b = vettore colonna, termine noto
% Output: x= vettore soluzione 

[n,m]=size(L); % restituisce righe e colonne della matrice
if n~=m
    warning('La matrice non è quadrata')
    x= [ ];
else
    [p,q]=size(b);
    if p~=n || q~=1 
        warning('Il vettore termine noto non è compatibile con la matrice')
        x=[ ];
    else
        % la matrice e' quadrata, il vettore termine noto e' colonna della 
        % stessa dimensione di L
        % risolvo
        x=zeros(n,1); % inizializzo il vettore soluzione ad un vettore nullo
       for i=1:n
           s=0;
           for j=1:i-1
               s=s+L(i,j)*x(j);
           end
          x(i)=(b(i)-s)/L(i,i);
       end
    end
end
    
