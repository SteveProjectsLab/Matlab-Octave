close all
clear all


Tc= 0.01;

Gzas= tf(1, conv([1 -0.2],[1 -.01]), Tc);

%% Calcolo Gcl per controllo DeadBeat

% Gzas NON ha poli e zeri instabili -> NON fattorizzo Gcl


% Gcl= 1/ z^P,

% con P= GRADO RELATIVO Gzas => = 2
%-> garantisce inseguimento tempo min

z= tf('z', Tc);
Gcl= 1/ z^2;

C1= minreal((1/Gzas) * (Gcl/ (1-Gcl))); %Con minreal faccio cancellazione
 