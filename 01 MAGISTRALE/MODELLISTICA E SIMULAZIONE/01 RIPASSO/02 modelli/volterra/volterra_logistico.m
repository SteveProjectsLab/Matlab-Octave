clear
close all
clc

%##########################################################################
% volterra II ( con dinamica logistica delle prede)
%##########################################################################

a=0.1 %tasso natalità
b=0.1 %tasso che indica probabilità di incontro e capacità predatoria
gammma=0.1 %dinamica malthusiana
delta=0.1 % probabilità di incontro, capacità predatoria, conversione in biomassa

K=100 % capacità portante

syms x y
f=[a*x-b*x*y- a/K*x^2;
    -gamma*y+delta*x*y]