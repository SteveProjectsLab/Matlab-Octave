close all
clear all


Tc= 0.01;

Gzas= tf(1, conv([1 -0.2],[1 -.01]), Tc);

%% CONTROLLO ANALITICO

%So che Gcl= C*Gzas/ 1+C*Gzas

%Quindi -> C= (1/Gzas)*(Gcl/ 1-Gcl)

% Devo ottenere Gcl, per poter calcolare C


%% Specifiche, mappeate su Gcl !!

% 1) Smorzamento tra 0.7 e 0.9 
% 2) Pulsazione naturale tra 0.1pi/T e 0.3pi/T
% -> DA GRAFICO LUOGO SMORZ/PULS: COSTANTE

%Trovo coppia di poli compl-coniug. per Gcl:
%0.6 +- 0.2 j


% 3)Errore a regime nullo 
%-> Gcl con guadagno 1 -> Gcl(1)=1;



% Costruisco un Gcl= K/ (z-p1)(z-p2) DISCRETA!!

p1= 0.6 +0.2j;
p2= 0.6 - 0.2j;

Gcl= tf(1, conv([1 -p1], [1 -p2]), Tc);

% Calcolo guadagno:

guadagno = dcgain(Gcl);

%MA: Gcl deve avere guadagno =1

Gcl= (1/guadagno) * Gcl;


%% Verifica grado di Gcl
%Devo avere che il grado relativo di Gcl
%sia >= del grado relativo di Gzas

%Altrimenti aggiusto

% Gzas ha : grado 0 num 
%           grado 2 den

% Come Gcl ! -> VA BENE

% Altrimenti, potrei risolvere con un ritardo,
% di Tc a Gcl



%% Calcolo C1

C1= minreal((1/Gzas) * (Gcl/ (1-Gcl))); %Con minreal faccio cancellazione
