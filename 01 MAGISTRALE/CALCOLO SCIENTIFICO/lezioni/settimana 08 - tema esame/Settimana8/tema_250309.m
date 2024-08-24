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

x=meg(A,b,0)

% calcolo det(A) per verificare che sia non singolare
det(A)
% vedo che e' non nullo, mi aspetto che meg con pivotazione arrivi a
% terminazione

x=meg(A,b,1)

% punto 2.b
x_ex=[1;1/2;1/3;1/4;1/5;1/6]; % sol esatta
xn=A\b; % soluzione numerica

err_a=norm(x_ex-xn) % errore assoluto tra soluzione esatta e numerica
err_r=err_a/norm(x_ex) % errore relativo

% calcolo il condizionamento della matrice
KA=cond(A)
% stimo l'errore relativo sulla soluzione esatta
stima=KA*2*eps

% trovo err_r ~ 1.6e-10, stima ~3.6e-9 e quindi la stima a priori e'
% verificata