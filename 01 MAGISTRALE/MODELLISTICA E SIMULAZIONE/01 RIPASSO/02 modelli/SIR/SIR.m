clear 
close all
clc

b=0.004     %probabilità di incontro e capacità contagio
g=0.04      % velocità con cui gli ifetti guariscono
u=1e-3      % tasso di mortalità altre cause
d=0.01      % tasso di mortalità causa virus

x0=[97,3,0];    % condizioni iniziali


%% SIR BASE

syms S I R
f=[ -b*S*I;
    b*S*I-g*I;
    g*I]

%%  SIR con nascita e decessi dovuti ad altre cause
syms S I R
f=[ delta-b*S*I-u*S;
    b*S*I-g*I-u*I;
    g*I-u*R]

%% SIRD con decessi dovuti al covid
syms S I R D
f=[ delta-b*S*I-u*S;
    b*S*I-g*I-u*I-d*I;
    g*I-u*R;
    d*I]
