close all
clear all
clc

Tc= 0.01;
den = conv([1 -0.2],[1 -.01]);
Gzas= tf(1, den, Tc) %è nota

% facendo i calcoli Gcl dovrà avere
% Gcl(1)=1
% Gcl deve avere due poli complessi coniugati in 0,6+-0,2j 

% inserisco Gcl



p1= 0.6 +0.2j;
p2= 0.6 - 0.2j;

Gcl= tf(1, conv([1 -p1], [1 -p2]), Tc);
guadagno =dcgain(Gcl) % vale 5

%MA gcl che cerco deve avere guadagno 1

Gcl=1/guadagno*Gcl
guadagno =dcgain(Gcl) % vale 5

C1= minreal((1/Gzas) * (Gcl/ (1-Gcl)))



