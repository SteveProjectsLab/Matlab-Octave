function [X]=inversa(A)
% calcolo l'inversa di matrice
% Input: A = matrice nxn invertibile
% Output: X = matrice inversa di A

[n,m]=size(A);
if n==m
    % calcolo la fatt. LU una volta per tutte
    [L,U,P]=fattlu(A,1);
    % ciclo sui vettori colonna di X
    X=zeros(n);

    for j=1:n
        % genero b=e_j vettore j-simo della base canonica
        b=zeros(n,1); b(j)=1;
        y=sost_avanti(L,P*b); % risolvo Ly=Pb
        x=sost_indietro(U,y); % risolvo Ux=y
        X(:,j)=x; % copio x nella colonna j-sima di X
    end
else
    disp('Le dimensioni di A non sono uguali')
    X=[];
end
