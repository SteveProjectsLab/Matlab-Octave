function [x]=meg_pivot(A,b)
% meg_pivot : risoluzione di un sistema lineare quadrato Ax=b con 
% il metodo di eliminazione di Gauss con pivotazione e sostituzioni all'indietro
% x=meg_pivot(A,b);
% Input: A = matrice quadrata n x n
%           b = vettore colonna di dimensione n, termine noto
% Output: x = vettore colonna di dimensione n, soluzione del sistema
% avviso: non viene fatto controllo sulle dimensioni


n=length(A); % numero di righe= numero di colonne
% [n,~]=size(A)
% eliminazione di Gauss
for k=1:n-1 % passo del meg
    % pivotazione
    [~,r]=max(abs(A(k:n,k))); % A(k:n,k) estrae la sottocolonna di A con indici 
    % di riga da k a n e indice di colonna k
    % x= massimo calcolato
    % r = indice dell'elemento massimo all'interno del sottovettore
    % A(k:n,k)
    r=r+k-1; % adesso r e' l'indice di riga sulla matrice globale
    % scambio le righe r e k
    temp=A(k,:); 
    A(k,:)=A(r,:);
    A(r,:)=temp; 
    % scambio b(k) con b(r)
    temp=b(k);
    b(k)=b(r);
    b(r)=temp;
    % continuo con il MEG
    for i=k+1:n % riga su cui fare l'eliminazione
        if A(k,k)==0
            warning('elemento diagonale nullo')
            x=[ ];
            return
        end
        mik=A(i,k)/A(k,k);
        for j=k+1:n
            A(i,j)=A(i,j)-mik*A(k,j);
        end
        b(i)=b(i)-mik*b(k);
    end
end

U=triu(A); % copio nel triangolo superiore di U il triangolo superiore di A

% chiamo la sostituzione all'indietro
x=backsub(U,b);


