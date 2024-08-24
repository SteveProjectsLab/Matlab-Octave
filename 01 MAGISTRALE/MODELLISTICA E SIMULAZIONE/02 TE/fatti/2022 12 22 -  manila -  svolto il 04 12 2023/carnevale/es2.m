clear all

syms x1 x2 u
ueq=0;
x0=[-0.1;0.1];
F=[(x1^2+x1)*x2;-4*x2+x1-x2*u+3*u];

% calcolo i pti di equilibrio
xeq=solve(subs(F,u,ueq)==0);    % dx/dt=0=>F=0
xeq1=double([xeq.x1(1),xeq.x2(1)])
xeq2=double([xeq.x1(2),xeq.x2(2)])
%studio la stabilità dei pti di equilibrio
J_s=jacobian(F,[x1,x2]);
J1=double(subs(J_s,[x1,x2,u],[xeq1(1),xeq1(2),ueq]));
J2=double(subs(J_s,[x1,x2,u],[xeq2(1),xeq2(2),ueq]));

aval1=eig(J1) % situazione di indecidibilità
aval2=eig(J2) % sella->instabile
% Dalla simulazione vedo che xeq1 è stabile

% y1: giallo, y2: blu

% quale uscita usare per linearizzare il sistema?
% Per la lin. I-O  devo avere grado relativo pari a 2.
% Verifico il grado relativo quando linearizzo rispetto all'uscita
% y1 o y2

% Grado relativo: numero di volte che devo derivare l'uscita per avere
% dipendenza esplicita dall'ingresso
% y1
y1=5*x1;
% y1 non dipende da u=> gr1>0
% Cacolo dy1/dt=dy1/dx*dx/dt=dy1/dx*F
dy1=jacobian(y1,[x1,x2])*F 
% dy1 non dipende da u => gr1>1
ddy1=jacobian(dy1,[x1,x2])*F
% ddy1 dipende da u => gr1=2

% y2
y2=3*x2;
% y2 non dipende da u => gr2>0
dy2=jacobian(y2,[x1,x2])*F 
% dy2 dipende da u => gr2=1

% Per la linearizzazione I-O dovrò usare 
% necessariamente y1