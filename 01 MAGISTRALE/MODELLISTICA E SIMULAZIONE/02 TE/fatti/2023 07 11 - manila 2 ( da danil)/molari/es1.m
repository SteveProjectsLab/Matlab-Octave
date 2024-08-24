%Molari Stefano 727197

% esercizio 1

%--------------------------------------------------------------------------
%punto 1: modellizzare il sistema
%--------------------------------------------------------------------------
% qtà melange: x1
% qtà vermi sabbie: x2

%dx1/dt = 22*x2-0.5*x1-0.1*x1
%dx2/dt = x2*(1-x2/100)-0.9*x2

syms x1 x2
f=[2*x2-0.5*x1-0.1*x1;x2*(1-x2/100)-0.9*x2]

%
%--------------------------------------------------------------------------
% Calcolare i punti di equilibrio del sistema e studiarne la stabilità
% a fronte di una quantit`a di spezia raccolta pari a 1. 
% Evidenziare eventuali criticit`a nel sistema e/o nella modellizzazione 
% deducibili dal calcolo.
%--------------------------------------------------------------------------
