clear
close all
clc
%%
%##########################################################################
% volterra I ( dinamica solo malthusiana prede)
%##########################################################################

a=0.1 %tasso natalità
b=0.1 %tasso che indica probabilità di incontro e capacità predatoria
gammma=0.1 %dinamica malthusiana
delta=0.1 % probabilità di incontro, capacità predatoria, conversione in biomassa

syms x y
f=[a*x-b*x*y;
    -gamma*y+delta*x*y]

