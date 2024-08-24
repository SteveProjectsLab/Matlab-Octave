clear
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%creo un vettore e lo stampo

vettore = [1,2,3,4,5,6,7];
fprintf('vettore\n');
for k = 1: length(vettore)
    fprintf('%d ',vettore(k));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%creo una matrice

matrice = [1 2 3 
4 5 6
7 8 9];

r=5;
c=5;

mat1 = zeros(r,c);
mat2 = rand (r,c);
mat3 = ones(r,c);

matRand = rand(r,c);
matIdentita = eye(r);
diagonale= diag(123);

fprintf('\n\nmatrice\n');
for k = 1: r%riga
    for j=1:c%colonna
        fprintf('%d ',matIdentita(k,j));
    end
    fprintf('\n');
end

fprintf('\n\nstampo seconda colonna\n');
