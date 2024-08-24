% testo il gradiente e il gradiente coniugato
A=[6 1 -2 2 1;
    1 3 1 -2 0;
    -2 1 4 -1 -1;
    2 -2 -1 4 2;
    1 0 -1 2 3];
b=[15;2;3;21;21];
x0=rand(5,1);
tol=1e-12;
kmax=500;


%[x,res,k,resvec]=gradiente(A,b,x0,tol,kmax)
[x,res,k,resvec]=gradiente_coniugato(A,b,x0,tol,kmax)
%%
figure(1); clf
semilogy((0:k)', resvec,'o-')
grid on
xlabel('k')
ylabel('norma del residuo')

