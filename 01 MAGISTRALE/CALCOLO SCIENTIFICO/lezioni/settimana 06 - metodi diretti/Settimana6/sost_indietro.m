function [x]=sost_indietro(U,b)
% metodo delle sostituzioni all'indietro per risolvere Ux=b
% Input: L = matrice quadrata triangolare inferiore
%        b = vettore colonna termine noto
% Output: x = vettore colonna soluzione

[n,m]=size(U);
[p,r]=size(b);
% risolvo solo se n==m==p e r==1
if n==m && m==p && r==1
x=zeros(n,1); % inizializzo il vettore soluzione
% algoritmo vero e proprio
for i=n:-1:1
   % calcolo la sommatoria
    s=0;
   for j=i+1:n
       s=s+U(i,j)*x(j);
   end
   x(i)=(b(i)-s)/U(i,i);
end
else
    disp('sistema non compatibile, correggi le dimensioni dei dati')
    x= [ ];
end
