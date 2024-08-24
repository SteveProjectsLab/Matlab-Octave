load matriceB 
v=eig(B);

% calcolo il determinante come prodotto degli autovalori
d=1;

for i=1:100
    d=d*v(i);
    fprintf('i=%d, d=%13.6e \n',i,d)
end