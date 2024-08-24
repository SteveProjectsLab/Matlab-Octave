function [C] = matrixProduct (A,B)
%Effettua il prodotto tra le matrici A e B
%input: 
%   A -> prima matrice (m x n)
%   B -> seconda metrice (n x p)
%output:
%   C -> matrice risultante (m x p)

[rA,cA] = size(A);
[rB,cB] = size(B);
if(cA ~= rB)
    disp(['Il numero di colonne di A è diverso dal numero di righe di B, ' ...
        'non è possibile fare il prodotto tra le matrici'])
    C=[];
else
    C=zeros(rA,cB);
    B=B';
    for k=1:rA
        for l=1:cB
            C(k,l)=sum(A(k,:).*B(l,:));
        end
    end
end
