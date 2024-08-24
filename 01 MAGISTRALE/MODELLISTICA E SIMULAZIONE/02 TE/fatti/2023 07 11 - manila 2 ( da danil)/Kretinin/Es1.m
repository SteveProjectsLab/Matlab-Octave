clear all
clc
% 1: Modellizzazione del sistema
    % x1: quantità di melange 
    % x2: quantità di vermi 
    syms x1 x2   
    f = [2*x2-0.5*u-0.1*x1;    % dx1/dt : variazione di melange 
        x2*(1-(x2/100))-0.9*x2];% dx2/dt : variazione di vermi
% 2: Punti di equilibrio del sistema
    xeq = solve (f==0);         % trovo 2 punti di equilibrio
    J = jacobian(f,[x1,x2]);
    % caratteristiche del primo punto di equilbrio
    xeq1 = double([xeq.x1(1),xeq.x2(1)]);
    J1 = double(subs(J,[x1,x2],[xeq1(1),xeq1(2)]));
    aval1 = eig(J1) % punto di sella (=> instabile)
    % caratteristiche del secondo punto di equilibrio
    xeq2 = double([xeq.x1(2),xeq.x2(2)]);
    J2 = double(subs(J,[x1,x2],[xeq2(1),xeq2(2)]));
    aval2 = eig(J2) % nodo (stabile)
% Criticità del sistema
    % la spezia raccolta rappresenta l'ingresso del sistema con cui sto
    % modellizzando: la stabilità del sistema non dipende dall'ingresso,
    % quindi indipendentemente dalla spezia raccolta si hanno problemi di
    % stabilità nel punto xeq1=[0 0], cioè quando non ci sono più melange e
    % (di conseguenza) i vermi si sono estinti