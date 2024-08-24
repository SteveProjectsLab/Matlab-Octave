%##################################################################
% 1. Calcolare e studiare la stabilit`a dei punti di equilibrio 
% del sistema per u=0.
syms x1 x2 u
f=[(x1^2+x1)*x2;
    -4*x2+x1-x2*u+3*u]
y=5*x1

ueq=0;

xeq_s=solve(subs(f,u,ueq)==0)
xeq1=double([xeq_s.x1(1) xeq_s.x2(1)])
xeq2=double([xeq_s.x1(2) xeq_s.x2(2)])

% xeq1 =
% 
%      0     0
% 
% 
% xeq2 =
% 
%    -1.0000   -0.2500

% per studiare la stabilità devo calcolare la jacobiana
J_s=jacobian(f,[x1 x2])
% J_s =
% 
% [x2*(2*x1 + 1), x1^2 + x1]
% [            1,   - u - 4]

J1=double(subs(J_s,[x1 x2 u],[xeq1 ueq]))
J2=double(subs(J_s,[x1 x2 u],[xeq2 ueq]))

% calcolo gli autovalori
aval1=eig(J1)
aval2=eig(J2)

% aval1 =
% 
%     -4
%      0    indicibile
% 
% 
% aval2 =
% 
%    -4.0000
%     0.2500    sella
%##################################################################
% 2. Progettare il controllo linearizzante attraverso I-O linearization.

%devo calcolare il grado relativo del sistema
% in y non compare u, gr>0
% calcolo la derivata prima
F=f;h=y;
dy=jacobian(h,[x1 x2])*f

% dy =
% 
% 5*x2*(x1^2 + x1)

% non compare u, gr>1

% calcolo la derivata seconda
ddy=jacobian(dy,[x1 x2])*f

% ddy =
% 
% (5*x1^2 + 5*x1)*(3*u + x1 - 4*x2 - u*x2) + 5*x2^2*(2*x1 + 1)*(x1^2 + x1)

% compare la u, quindi gr rel sistema =2 = gr sistema quindi ok IO

syms v
u_lin=solve(ddy==v,u)

% u_lin =
% 
% ((5*x1^2 + 5*x1)*(x1 - 4*x2) - v + 5*x2^2*(2*x1 + 1)*(x1^2 + x1))/((5*x1^2 + 5*x1)*(x2 - 3))
 
%##################################################################
% 3. Determinare un controllo in retroazione per la regolazione 
% a 0 dello stato che permetta avere dinamica definita dalla coppia 
% di autovalori autovalori [a1;2*a1], dove a1 deve permettere 
% al sistema (considerando la linearizzazione ”perfetta”) 
% di raggiungere l’equilibrio in un tempo T=2s.
Alin=[0 1;
      0 0];
Blin=[0;1];
Clin=[1 0];

T=2;
td=T/5;
pd=-1/td;
a1=pd;
K=place(Alin,Blin,[a1;2*a1])

% K =
% 
%    12.5000    7.5000

f=[(x1^2+x1)*x2;
    -4*x2+x1]

T=[h;jacobian(h,[x1 x2])*f]


% T =
% 
%             5*x1
% 5*x2*(x1^2 + x1)

x0=[3;5];