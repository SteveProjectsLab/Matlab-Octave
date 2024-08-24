 close all 
clear all
clc
close all
clear all

% Definisco il sistema discreto Gzas

Tc=0.1;

Gzas = tf(10, conv([1 -0.1],[1 -0.8]), Tc);

% Definisco Gcl

% Errore a regime nullo -> guadagno =1

% Smorzamento Poli tra o.7 e 0.9
% Pulsazione naturale tra 0.3pi/Tc e 0.4pi/Tc

p1=0.3 +0.3j;

p2=0.3 - 0.3j;

% Gcl avrà forma K/ (z- p1)*(z- p2), con k= guadagno

Gcl= tf(1, conv([1 -p1],[1 -p2]), Tc);


guadagno = dcgain(Gcl); % È diverso da 1!


Gcl= (1/guadagno)*Gcl; % Riporto il guadagno a 1


% Creo C = (1/Gzas)* (Gcl/ (1- Gcl))

 C = minreal((1/Gzas)* (Gcl/ (1- Gcl)));
 


% Simulo su simulink



% Punto 2 uguale a prima, ma guadagno deve essere = 10

Gcl2= Gcl*10;

C2 = minreal((1/Gzas)* (Gcl2/ (1- Gcl2)))

