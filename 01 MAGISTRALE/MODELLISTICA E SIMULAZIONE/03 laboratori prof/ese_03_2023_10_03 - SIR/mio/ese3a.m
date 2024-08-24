clear all
close
clc

% dx/dt=Ax+Bu
% y=Cx+Du
b=0.004
g=0.04
delta=0.1
mu=1e-3
xo=[97,3,0]




syms S I R %definisco variabili di  tipo simbolico
f=[delta-b*S*I-mu*S;b*S*I-g*I-mu*I;g*I-mu*R];
