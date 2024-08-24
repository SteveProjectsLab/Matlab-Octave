function [L,U,P]=fattlu(A,ipiv)
% fattorizzazione LU di A
% Input: A = matrice quadrata non singolare
%       ipiv: =0 non implemento la pivotazione
%             =1 implemento la pivotazione
% Output: L = fattore triangolare inferiore della fattorizzazione
%         U = fattore triangolare superiore della fattorizzazione
%         P = matrice di pivotazione
% 
[n,m]=size(A);
 
if n==m  
%  fattorizzazione
P=eye(n); % matrice dellla pivotazione
for k=1:n-1
% pivotazione
    if ipiv==1
       [~,ind]=max(abs(A(k:n,k)));
       r=ind+k-1; % indice della riga da scambiare con la riga k
       %fprintf('k=%d, r=%d \n',k,r)
       % scambio le righe di A
       temp=A(k,:);
       A(k,:)=A(r,:);
       A(r,:)=temp;
       % scambio le righe di P
       temp=P(k,:);
       P(k,:)=P(r,:);
       P(r,:)=temp;
    end

    for i=k+1:n
        A(i,k)=A(i,k)/A(k,k);
        for j=k+1:n
            A(i,j)=A(i,j)-A(i,k)*A(k,j);
        end
    end
end

% salvo in U la matrice triangolare superiore da A
U=triu(A);
% salvo in L i moltiplicatori e 1 sulla diag. principale
L=tril(A,-1)+eye(n);
else
    disp('le dimensioni di A non sono uguali')
    L=[]; U=[]; P=[];
end
