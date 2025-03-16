%% sistema con A triangolare superiore
A=[ 1 1 3 0;
    0 1 2 -1;
    0 0 4 1;
    0 0 0 3]

b=[2 2 6 6]';

x=sost_indietro(A,b)

%% sistema con A triangolare inferiore
A=[ 1 0 0 0;
    5 1 0 0;
    2 2 4 0;
    4 1 0 3]

b=[2 2 6 6]';

x=sost_avanti(A,b)

%% sistema A generico MEG + MEG pivotazione

A=[10 4 3 -2; 2 20 20 -1; 3 -6 4 3; -3 0 3 1];

b=[5;24;13;-2];

x=meg(A,b)  % senza pivotazione

x=meg_pivot(A,b)    % con pivotazione

%% sistema A generico LU + LU pivotazione
A=[10 4 3 -2; 2 20 20 -1; 3 -6 4 3; -3 0 3 1];
b=[5;24;13;-2];

[L,U]=lufact(A,0);  % fatt LU senza pivoting
%[L,U,P]=lufact(A,1);  % fatt LU con pivoting

y=sost_avanti(L,b); % risolvo Ly=b
%y=sost_avanti(L,P*b); nel caso uso pivoting

x=sost_indietro(U,y) % risolvo Ux=y

%% Lu matlab
[L,U]=lu(A)
y=L\b
x=U\y

[L,U,P]=lu(A)
y=L\(P*b)
x=U\y

[L,U,P,Q]=lu(sparse(A))


%% fattorizzazione QR
A=[ 0 1;
    0.06 1; 
    0.14 1; 
    0.25 1; 
    0.31 1;
    0.47 1;
    0.6 1;
    0.7 1]

b=[0 ;0.08 ;0.14 ;0.20 ;0.23 ;0.25; 0.28 ;0.29];

[Q,R]=qr(A)

% pag 181 libro

Qt=Q(:,1:2)
Rt=R(1:2,:)
xstar= Rt\(Qt'*b)
A=Q*R
