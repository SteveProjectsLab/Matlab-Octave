% test fattlu
A=[10 4 3 -2;
    2 20 20 -1;
    3 -6 4 3;
    -3 0 3 1];
b=[5;24;13;-2];

% fatt LU senza pivoting
[L,U]=fattlu(A,0);
% risolvo Ly=b
y=sost_avanti(L,b);
% risolvo Ux=y
x=sost_indietro(U,y)

% soluzione di controllo calcolata con \
xmatlab=A\b

%% fatt LU con pivoting
A=[1 4 3 -2;
    2 20 20 -1;
    3 -6 4 3;
    -3 0 3 1];
b=[5;24;13;-2];

[L,U,P]=fattlu(A,1);
% risolvo Ly=P*b
y=sost_avanti(L,P*b);
% risolvo Ux=y
x=sost_indietro(U,y)
