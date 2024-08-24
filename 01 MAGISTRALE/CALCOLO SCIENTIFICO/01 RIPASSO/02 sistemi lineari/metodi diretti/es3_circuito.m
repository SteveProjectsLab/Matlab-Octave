% es_circuito
R1=1; R2=3; R3=0.5; R4=4; R5=2; R6=2;
V1=10; V2=7;
A=[-1 1 1 0 0 0;
    0 0 -1 1 1 0;
    0 -1 0 -1 0 1;
    0 -R2 R3 R4 0 0;
    0 0 0 -R4 R5 -R6;
    R1 R2 0 0 0 R6];
b=[0;0;0;V2; 0; V1-V2 ];

%% richiamo MEG senza pivotazione
x=meg(A,b)
% meg non arriva a terminazione perche' c'e' 
% la sottomatrice 2x2 singolare

%% richiamo MEG con pivotazione
x=meg_pivot(A,b)

%% verifico con matlab

x=A\b