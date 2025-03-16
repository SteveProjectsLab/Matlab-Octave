clear all
close
clc


A=[10 4 3 -2;
    2 20 20 -1;
    3 -6 4 3;
    -3 0 3 1];

b=[5;24;13;-2];

x=meg(A,b)

% x =
%    2.7379e+00
%    5.1310e+00
%   -3.3862e+00
%    1.6372e+01

x=A\b%ok, stesso risultato


%% MEG PIVOTAZIONE
A=[10 4 3 -2;
    2 20 20 -1;
    3 -6 4 3;
    -3 0 3 1];
b=[5;24;13;-2];

x=meg_pivot(A,b)


