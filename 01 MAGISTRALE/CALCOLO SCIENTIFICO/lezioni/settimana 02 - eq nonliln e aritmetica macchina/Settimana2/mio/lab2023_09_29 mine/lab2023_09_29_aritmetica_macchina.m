clear
close all
clc

load matriceB
autovalori=eig(B);
determinante=det(B);
rango=rank(B);

d=1;
n=length(autovalori);
for i=1:n
    d=d*autovalori(i);
    fprintf ( 'i=%d d=%13.6e \n',i , d )
end

%va in underflow