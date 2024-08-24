function [c]=prodotto_matrici(a,b)
% calcolo il prodotto tra due matrici
% istruzione di chiamata: c=prodotto_matrici(a,b)
% input a, b: matrici
% output c=a*b

[na,ma]=size(a);
[nb,mb]=size(b);

if (ma==nb)
% calcolo il prodotto
n=na; m=ma; p=mb;
c=zeros(n,p); % inizializzo la matrice c
for i=1:n
    for j=1:p
        % calcolo la sommatoria
        for k=1:m
            c(i,j)=c(i,j)+a(i,k)*b(k,j);
        end
    end
end
else
  disp('Attenzione il n. di col. di a è diverso dal n. di righe di b')
  c=[ ];
end
