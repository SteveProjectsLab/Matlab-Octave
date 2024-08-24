close
clear all
clc

num =[10];
den = [0.1 1.1 1];

sys_G=tf(num,den);

% SPECIFICA NEL DOMINIO DEL TEMPO
% posso mappare su:

%-------------------------------------------------------------
% e(inf)=0 per ingressi a scalino
%-------------------------------------------------------------
    % 2 tecniche di progettazione!
         % fdt tutto sistema retroazionato Gcl=L/(1+L)            
            % 1. Gcl deve essere stabile
            % 2. Gcl deve avere guadagno unitario 
         % caratteristiche su L 
            % L deve avere un integratore

% L(s) quindi deve avere un integratore
%-------------------------------------------------------------               
% sovraelongazione massima 10%
%-------------------------------------------------------------
    % legata al coeff di smorzamento dei poli complessi coniugati
    % se avesse poli reali non oscilla

    % guardo  il grafico
    % vado a y=10% e leggo quindi smorzamento =0.6
    % PM di L = 100 volte lo smorzamento
    % quindi 60 di margine di fase


    % quindi devo avere PM>100*0.6 = 60
%-------------------------------------------------------------
% arrivi a regime in t=1s
%-------------------------------------------------------------
    % PM > 75 ( non oscilla )
        % ( in L)  L deve avere wt =5/T
        % (in Gcl) Pm > 75 devo avere polo dominante in 5/T
    % PM <z 75 ( oscilla )    
        % ( in L)  wt=wn
        % (in Gcl) wn=4/£T

     % quindi so che T = 4/(csi*wn) = 4/(0.6wn) = 6.67 = wt

   % vedo 6.67 come un valore minimo

%-------------------------------------------------------------

   % queste sono specifiche approssimate su L, però io devo garantire le
   % specifiche nel tempo