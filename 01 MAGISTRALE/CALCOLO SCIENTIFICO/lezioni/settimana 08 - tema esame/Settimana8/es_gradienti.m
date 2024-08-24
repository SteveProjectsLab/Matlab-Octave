% es bicgstab

A=[6 1 -2 2 1;
    0 -3 3 -2 1;
    2 0.5 5 -1 -2;
    0 1 2 -3 2;
    0.5 -1 1 0.4 2];
b=[15;0;4;6;13.1];

% definisco i dati per chiamare i meto
x0=rand(5,1);

tol=1e-12;
kmax=500;

% metodo del gradiente
[xg,resg,iterg,resvg]=gradiente(A,b,x0,tol,kmax);

% metodo del gc
[xgc,resgc,itergc,resvgc]=gradiente_coniugato(A,b,x0,tol,kmax);

% metodo del bcgstab
[xb,resb,iterb,resvb]=bcgstab(A,b,x0,tol,kmax);

figure(1); clf
semilogy((0:iterg)',resvg,'Linewidth',2,'Displayname','gradiente')
legend('-dynamiclegend')
hold on
semilogy((0:itergc)',resvgc,'Linewidth',2,'Displayname','GC')
semilogy((0:iterb)',resvb,'Linewidth',2,'Displayname','Bcgstab')
grid on
xlabel('iterazione')
ylabel('norma del residuo')









