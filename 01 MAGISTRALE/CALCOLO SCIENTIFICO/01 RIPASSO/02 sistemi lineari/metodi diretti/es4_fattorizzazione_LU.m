clear 
close all
clc
% test fattlu
A=[10 4 3 -2;
    2 20 20 -1;
    3 -6 4 3;
    -3 0 3 1];
b=[5;24;13;-2];

% fatt LU senza pivoting
[L,U]=lufact(A,0);
% risolvo Ly=b
y=sost_avanti(L,b);
% risolvo Ux=y
x=sost_indietro(U,y)

% soluzione di controllo calcolata con \
xmatlab=A\b

%% fatt LU con pivoting
clc
A=[1 4 3 -2;
    2 20 20 -1;
    3 -6 4 3;
    -3 0 3 1];
b=[5;24;13;-2];

[L,U,P]=lufact(A,1);
% risolvo Ly=P*b
y=sost_avanti(L,P*b);
% risolvo Ux=y
x=sost_indietro(U,y)

%% fattorizzazione LU in Matlab
[L,u]=lu(A)
[L,U,P]=lu(A)

%% es_pivot + confronto con soluzione esatta
clc
A=[1 1+0.5e-15 3;
    2 2 20;
    3 6 4];
b=[5+0.5e-15;
    24;
    13];

% risoluzione senza pivotazione

disp('senza pivoting')
[L,U]=lufact(A,0);
y=sost_avanti(L,b);
x=sost_indietro(U,y)

x_esatta=ones(3,1)% conosco la soluzione esatta
err=norm(x-x_esatta)/ norm(x_esatta)% calcolo quindi l'errore
% err =   4.0825e+00
% cioè un errore relativo del 408%


% risoluzione con pivotazione

disp('con pivoting')
[L,U,P]=lufact(A,1);
y=sost_avanti(L,P*b);
x=sost_indietro(U,y)


x_esatta=ones(3,1)% conosco la soluzione esatta
err=norm(x-x_esatta)/ norm(x_esatta)% calcolo quindi l'errore
% err =   1.1466e-15
% cioè un errore relativo del 10^-13%


%NB con la pivotazione tengo sotto controllo gli errori di arrotondamento


%% PIVOTAZIONE TOTALE
clc
[L,U,P,Q]=lu(sparse(A))

%% calcolo inversa con LU
% function [X]=inversa(A)
% % calcolo l'inversa di matrice
% % Input: A = matrice nxn invertibile
% % Output: X = matrice inversa di A
% 
% [n,m]=size(A);
% if n==m
%     % calcolo la fatt. LU una volta per tutte
%     [L,U,P]=fattlu(A,1);
%     % ciclo sui vettori colonna di X
%     X=zeros(n);
% 
%     for j=1:n
%         % genero b=e_j vettore j-simo della base canonica
%         b=zeros(n,1); b(j)=1;
%         y=sost_avanti(L,P*b); % risolvo Ly=Pb
%         x=sost_indietro(U,y); % risolvo Ux=y
%         X(:,j)=x; % copio x nella colonna j-sima di X
%     end
% else
%     disp('Le dimensioni di A non sono uguali')
%     X=[];
% end
