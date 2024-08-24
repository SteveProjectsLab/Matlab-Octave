clear all 
clc
% 0. sistema nonlineare
    syms x1 x2
    u = 0;
    x0 = [3;5];
    f = [3*(x1+1)*x1*x2;    % dx1/dt
        -4*x2+x1-x2*u+3*u]; % dx2/dt
% 1. Punti di equilibrio
    xeq = solve(f==0);          % trovo 2 punti di equilibrio
    J = jacobian(f,[x1,x2]);
    % stabiltà del primo punto di equilibrio
    xeq1 = double([xeq.x1(1), xeq.x2(1)]);  % xeq1=[0 0]
    J1 = double(subs(J,[x1,x2],[xeq1(1),xeq1(2)]));
    aval1 = eig(J1);    % indecibilità (1 autovalore è nullo)
    % stabiltà del secondo punto di equilbrio 
    xeq2 = double([xeq.x1(2), xeq.x2(2)]);  % xeq2=[-1 -0.25]
    J2 = double(subs(J,[x1,x2],[xeq2(1),xeq2(2)]));
    aval2 = eig(J2);    % punto di sella (=> instabile)
% 2. Scelgo uscita per linerizzazione I/O del sistema
    syms x1 x2 u            % riscrivo il sistema con u simbolica
    f = [3*(x1+1)*x1*x2; -4*x2+x1-x2*u+3*u];    
    % caso A
        yA = 5*x2;  % non compare dipendenza esplicita da u => g>0
        dyA = jacobian(yA,[x1,x2])*f;   % compare u => il grado relativo 1 
        % non corrisponde all'ordine del sistema => non posso considerare 
        % questa uscita per la linearizzazione I/O
    % caso B
        yB = 2*x1;
        dyB = jacobian(yB,[x1,x2])*f;   % non compare u => derivo ancora
        ddyB = jacobian(dyB,[x1,x2])*f; % ho dipendenza esplicita da u e 
        % il grado relativo è massimo => uso questa uscita per lin. I/O
% 3. Controllo linearizzante che usa l'uscita yB del sistema nonlineare
    syms v
    ulin = solve(ddyB==v,u);    % uscita del controllore
    % ulin = (2*x1*(3*x1+3)*(x1-4*x2)-v+
    %       +x1*x2*(3*x1+3)*(2*x2*(3*x1+3)+
    %       +6*x1*x2))/(2*x1*(3*x1+3)*(x2-3))
% 4. Controllo in retroazione
    % sistema linearizzato nello spazio degli stati 
        % dz1/dt=z2
        % dz2/dt=v
        % y=z1
        A=[0 1;0 0];    B=[0;1];    C=[1 0];
    % parte dinamica
        % transitorio per raggiungere l'equilibrio: T=2s
        % => che corrisponde a circa 5*tau=5*(-1/a1)
        % => ricavo a1=-5/2=-2.5 e ho già entrambi gli autovalori
        a1 = -2.5;
        K=place(A,B,[a1,2*a1]);
    % Legge di controllo del sistema: v=-Kz=-K1*z1-K2*z2
