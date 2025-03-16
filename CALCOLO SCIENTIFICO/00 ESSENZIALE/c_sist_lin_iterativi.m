
A=[6 1 -2 2 1; 1 3 1 -2 0; -2 1 4 -1 -1; 2 -2 -1 4 2; 1 0 -1 2 3];
b=[15;2;3;21;21];

x0=rand(5,1);

tol=1e-12;
kmax=500;



%% gradiente

[x,res,k,resvec]=gradiente(A,b,x0,tol,kmax)


%% gradiente coniugato

[x1,res1,k1,resvec1]=gradiente_coniugato(A,b,x0,tol,kmax)

%% bcgstab

[x2,res2,k2,resvec2]=bcgstab(A,b,x0,tol,kmax)

%% rappresento gli errori
figure(1); clf

semilogy((0:k)', resvec,'DisplayName','G','Color','r','LineWidth',2)
hold on
semilogy((0:k1)', resvec1,'DisplayName','GC','Color','k','LineWidth',2)
hold on
semilogy((0:k2)', resvec2,'DisplayName','BICGStab','Color','b','LineWidth',2)
grid on
legend('-dynamicLegend')