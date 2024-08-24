function [x]=meg(A,b, ipiv)
% risoluzione di Ax =b con Metodo di eliminazione di Gauss
%  x=meg(A,b,ipiv)
% Input: A matrice quadrata non singolare
%        b = vettore colonna termine noto
%       ipiv: =0 non implemento la pivotazione
%             =1 implemento la pivotazione
% Output: x = soluzione del sistema
% 
[n,m]=size(A);
[p,r]=size(b);

if n==m && m==p && r==1
% riduzione del sistema
for k=1:n-1
% pivotazione
    if ipiv==1
       [~,ind]=max(abs(A(k:n,k)));
       r=ind+k-1; % indice della riga da scambiare con la riga k
       % fprintf('k=%d, r=%d \n',k,r)
       % scambio
       temp=A(k,:);
       A(k,:)=A(r,:);
       A(r,:)=temp;
       temp=b(k);
       b(k)=b(r);
       b(r)=temp;

    end

    for i=k+1:n
        mik=A(i,k)/A(k,k);
        for j=k+1:n
            A(i,j)=A(i,j)-mik*A(k,j);
        end
        b(i)=b(i)-mik*b(k);
    end
end
% salvo in U la matrice triangolare superiore da A
U=triu(A);
x=sost_indietro(U,b);

else
    disp('controlla le dimensioni di matrice e termine noto')
    x=[] ;
end
