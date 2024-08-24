function [x]=sost_avanti(L,b)
% metodo delle sostituzioni in avanti per risolvere Lx=b
% Input: L = matrice quadrata triangolare sup
%        b = vettore colonna termine noto
% Output: x = vettore colonna soluzione

[n,m]=size(L);
[p,r]=size(b);
% risolvo solo se n==m==p e r==1
if n==m && m==p && r==1
x=zeros(n,1); % inizializzo il vettore soluzione
% algoritmo vero e proprio
for i=1:n
   % calcolo la sommatoria
    s=0;
   for j=1:i-1
       s=s+L(i,j)*x(j);
   end
   x(i)=(b(i)-s)/L(i,i);
end
else
    disp('sistema non compatibile, correggi le dimensioni dei dati')
    x= [ ];
end
