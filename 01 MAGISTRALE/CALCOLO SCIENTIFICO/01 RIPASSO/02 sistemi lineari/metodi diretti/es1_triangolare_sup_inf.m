clear all
close 
clc

%% sistema con A triangolare superiore
A=[ 1 1 3 0;
    0 1 2 -1;
    0 0 4 1;
    0 0 0 3]
b=[2 2 6 6]';

x=sost_indietro(A,b)
% x =
% 
%     -3
%      2
%      1
%      2

% verifico con il comando matlab
x=A\b
% dà lo stesso risultato

%% sistema con A triangolare inferiore
A=[ 1 0 0 0;
    5 1 0 0;
    2 2 4 0;
    4 1 0 3]
b=[2 2 6 6]';

x=sost_avanti(A,b)

% x =
% 
%     2.0000
%    -8.0000
%     4.5000
%     2.0000

% verifico con il comando matlab
x=A\b
% dà lo stesso risultato


%% estrarre da una matrice la triangolare superiore o inferiore
U=tril(A)   % salvo la triangolare inferiore di A
U=triu(A)   % salvo la triangolare superiore di A


