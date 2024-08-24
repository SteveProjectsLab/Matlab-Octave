% testo la correttezza di sost_avanti
L=[2 0 0 0; 
   1 1 0 0;
   3 2 4 0;
   0 -1 1 3];
b=[2;2;9;3];

x=sost_avanti(L,b) 

%%

U=[1 1 3 0;
    0 1 2 -1;
    0 0 4 1;
    0 0 0 3];
b=[2;0;6;6];

x=sost_indietro(U,b)
%%
A=[10 4 3 -2;
    2 20 20 -1;
    3 -6 4 3;
    -3 0 3 1];
b=[5;24;13;-2];

x=meg(A,b,1)

%%
A=[1 1 3; 2 2 2; 3 6 4];
b=[5;6;13];

x=meg(A,b,0)