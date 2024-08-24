% es_pivot
A=[1 1+0.5e-15 3;
    2 2 20;
    3 6 4];
b=[5+0.5e-15;
    24;
    13];

% risoluzione senza pivotazione
disp('senza pivoting')
[L,U]=fattlu(A,0);
y=sost_avanti(L,b);
x=sost_indietro(U,y)

%% risoluzione con pivotazione
disp('con pivoting')
[L,U,P]=fattlu(A,1);
y=sost_avanti(L,P*b);
x=sost_indietro(U,y)
