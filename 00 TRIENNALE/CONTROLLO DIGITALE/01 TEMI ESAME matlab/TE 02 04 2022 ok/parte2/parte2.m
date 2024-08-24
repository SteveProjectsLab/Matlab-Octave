clear all
close all
clc

Tc = 0.1;

den = conv([1 -0.3],[1 -0.9])

Gzas = tf(10, den, Tc)

% devo avere guadagno uguale di Gcl = 5 

% 1/z^P

z = tf ('z',Tc);
% Tempo di inseguimento minimo -> Gcl= 1/z^2
Gcl = 1/z^2
guadagno= dcgain(Gcl)

Gcl=5*Gcl;

guadagno= dcgain(Gcl)

C=minreal((1/Gzas)*(Gcl/(1-Gcl)))



