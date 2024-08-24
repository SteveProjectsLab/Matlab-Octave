% tema d'esame del 25 marzo 2009
A=[1001 1001 0 0 0 0;
   1001 1001 1 0 0 0;
   0 1 1001 1001 0 0;
   0 0 1001 1001 1 0;
0 0 0 1 1001 1001;
0 0 0 0 1001 1001 ];

b=[3003/2;
9011/6;
7013/12;
35047/60;
22037/60;
11011/30];

% punto 2.a
% verifico che MEG senza pivotazione non arriva a terminazione perche' c'e'
% un minore principale nullo

x=meg(A,b)
% devo per forza utilizzare la pivotazione

% calcolo det(A) per verificare che sia non singolare
det(A)%   1.0020e+06
% vedo che e' non nullo, mi aspetto che meg con pivotazione arrivi a
% terminazione

x=meg_pivot(A,b)
% x =
%     1.0000
%     0.5000
%     0.3333
%     0.2500
%     0.2000
%     0.1667
%%
% punto 2.b
% conosco la soluzione esatta, devo calcolare l'errore in norma 2
x_ex=[1;1/2;1/3;1/4;1/5;1/6]; % sol esatta

xn=A\b; % calcolo la soluzione numerica

err_a=norm(x_ex-xn) % errore assoluto tra soluzione esatta e numerica
err_r=err_a/norm(x_ex) % errore relativo

% calcolo il condizionamento della matrice
KA=cond(A)
% stimo l'errore relativo sulla soluzione esatta
stima=KA*2*eps

% l'epsilon macchina è 2.2204e-16
% trovo err_r ~ 1.6e-10, stima ~3.6e-9 e quindi la stima a priori e'
% verificata