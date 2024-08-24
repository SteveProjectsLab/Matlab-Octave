% Ci potrebbero essere altri tipi di specifiche:
% 
% Progetta C tale che:
% 
%  1) einf= 0, su rif scalino
% 
% -> Gcl(1)=1;
% 
%  2) come sistema 1° ordine con polo dominante in -1 
%  
% -> Ragiono in t-continuo e poi discretizzo:
% 
% Gcl= 1/ s+1; 
% 
% Poi dicretizzo con Tustin e ottengo Gcl(z)

close all
clear all


Tc= 0.01;

Gzas= tf(1, conv([1 -0.2],[1 -.01]), Tc);


Gcl= tf(1, [1 1]);

Gcl= c2d(Gcl, Tc, 'tustin');

C1= minreal((1/Gzas) * (Gcl/ (1-Gcl)));
%Con minreal faccio cancellazione


% MA: così C1 ha grado num> grado den
% 
% --> Ritardo Gcl!

z= tf('z', Tc);

Gcl= Gcl/ z^2;

C1= minreal((1/Gzas) * (Gcl/ (1-Gcl)));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Progett C5 con:

% 1) einf=0;
% 
% 2) PO%= 0 -> sistema 1° ordine!
% 
% 3) Tass= 5s
% 
% -> Tass= 5*Tau -> polo= -1/tau -> wt= |Polo|
% 
% La C1 già calcolata già rispetta
