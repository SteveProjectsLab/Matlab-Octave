clear all
close all
clc

%data Gzas serie ZOH-sistema-campionatore

Tc = 0.1
num=10;
den=conv([1 -0.1], [1 -0.8]);
Gzas=tf(num, den,Tc)

%1. L'errore a regime a fronte di uno scalino deve essere pari a 0.
% devo avere G(1)=1
%2. Lo smorzamento dei poli dominanti in anello chiuso 
% deve essere compreso tra 0.7 e 0.9.
% guardo il grafico


% nella regione ottenuta scelgo 0.3 +- 0.2i

p1= 0.3 +0.2j
p2= 0.3 -0.2j


Gcl = tf(1, conv([1 -p1],[1 -p2]), Tc)
guadagno= dcgain(Gcl)
Gcl=1/guadagno*Gcl
guadagno= dcgain(Gcl)

C1 = minreal ((1/Gzas)* (Gcl/(1-Gcl)))

% a seguito di una modifica dell'impianto si vuole che il sistema
% abbia un'uscita pari a 10*A, dove A= ampiezza scalino

Gcl=10*Gcl
C2 = minreal ((1/Gzas)* (Gcl/(1-Gcl)))