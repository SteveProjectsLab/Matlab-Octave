clear all
alfa1=0.02; %
alfa2=0.001; %
K=100; %
b=0.1;
ueq=0.5;
x0=[10,10];
% x1: alga
% x2: pesci
% y=x1
% dx1/dt=x1(1-x1/K)-alfa1*x1*x2
% dx2/dt=-bx2+alfa2*x1*x2+u
syms x1 x2 u
f=[x1*(1-x1/K)-alfa1*x1*x2;-b*x2+alfa2*x1*x2+u];
xeq_s=solve(subs(f,u,ueq)==0)
xeq1=double([xeq_s.x1(1) xeq_s.x2(1)])
xeq2=double([xeq_s.x1(2) xeq_s.x2(2)])
xeq3=double([xeq_s.x1(3) xeq_s.x2(3)])
 
J_s=jacobian(f,[x1,x2])
J1=double(subs(J_s,[x1,x2,u],[xeq1,ueq]));
aval1=eig(J1)
J2=double(subs(J_s,[x1,x2,u],[xeq2,ueq]));
aval2=eig(J2)
J3=double(subs(J_s,[x1,x2,u],[xeq3,ueq]));
aval3=eig(J3)

% Calcoliamo e simuliamo il sistema linearizzato attorno al punto di
% equilbrio stabile xeq3

% il sistema linearizzato attorno al punto di equilibrio è un sistema
% in DeltaX, DeltaU, dove DeltaX=x-xeq3 e DeltaU=u-ueq. 
% Ha in generale la forma:
% d(DeltaX)/dt=A*DeltaX+B*DeltaU
% DeltaY=C*DeltaX+D*DeltaU

% Dove:
% A=df/dx=>Jacobiano
% B=df/du
% C=dg/dx
% D=dg/du

% NOTA1: nel nostro caso g=x1 (perché è esplicitato che l'uscita è x1)
g=x1

A3=J3;
B_s=jacobian(f,u)
B3=double(subs(B_s,[x1,x2,u],[xeq3,ueq]))
C_s=jacobian(g,[x1 x2]);
C3=double(subs(C_s,[x1,x2,u],[xeq3,ueq]))
D_s=jacobian(g,u)
D3=double(subs(D_s,[x1,x2,u],[xeq3,ueq]))

% Procedo alla linearizzazione I-O
F=f;
G=g;
h=g;
f=[x1*(1-x1/K)-alfa1*x1*x2;-b*x2+alfa2*x1*x2];
% la forma del sistema per cui possiamo utilizzare la linearizzazione i-o
% è:
% dx/dt=f(x)+g(x)*u=F(x,u)
% y=h(x)

% Nota: f non è quella di partenza (che ora è F). g non è quella di
% partenza (che ora è G), ma è diventata h. 
% In pratica: F=f+g*u

% Calcolo il grado relativo... (y=x1)
% il sistema ha grado relativo 0? h=x1; 
% No perché y=x1 non dipende direttamente da u
% il sistema ha grado relativo 1?
% Devo calcolare dy/dt=d(h(x))/dt=gradiente(h)*dx/dt=gradiente(h)*F
dy=jacobian(h,[x1,x2])*F
% No perché dy non dipende direttamente da u
% il sistema ha grado relativo 2?
% Devo calcolare d^2y/dt^2=d(dy)/dt=gradiente(dy)*dx/dt=gradiente(dy)*F
ddy=jacobian(dy,[x1,x2])*F
% ddy dipende direttamente da u=>il sistema ha grado relativo 2
% d^2y/dt^2=ddy=v (perché voglio avere Y(s)=1/s^2*V(s)
syms v
u_lin=solve(ddy==v,u)

% trovare v=-Kz+F t.c. la dinamica sia indicata 
% dagli autovalori (-1/10,-10) [K] e il sistema retroazionato insegua un
% setpoint costante (y=80) [F]
% n.b.: per posizionare gli autovalori di (A-BK) in (-1/10,-10), si usa il
% comando K=place(A,B,[-1/10,-10])
% simulare il sistema controllato
% Sappiamo che il sistema linearizzato è (ordine 2):
% A=[0 1;0 0]; B=[0;1]; C=[1 0]     (NOTA: è sempre così per sistemi
% linearizzati con I-O linearization e aventi ordine 2)
% Questo significa, sostituenzo v=-Kz+F=-k1*z1-k2*z2+F=>
% dz1/dt=z2
% dz2/dt=v=-k1*z1-k2*z2+F
% y=z1
% dove k1 e k2 mi devono garantire gli autovalori che voglio (posso usare
% place)
% e F deve garantirmi l'inseguimento di un setpoint ys=80 (il fatto che sia
% 80 è indifferente per la struttura del controllore). Quindi
% all'equilibrio: yeq=ys
% yeq=z1eq (valore di z1 all'equilibrio, essendo y=z1)
% Calcolo z1eq:
% dz1/dt=0 => z2eq=0
% dz2/dt=0 => -k1*z1eq-k2eq+F=0
% => z1eq=F/k1
% 
% Quindi yeq=z1eq=F/k1. Ma all'equilibrio devo avere yeq=ys (e devo
% calcolare F che mi garantisce questo)=>
% ys=F/k1 => F=k1*ys
% Quindi il controllo complessivo è v=-K*z+k1*ys
% Questo controllo mi garantisce il rispetto di entrambe le specifiche,
% devo solo trovare K
Alin=[0 1;0 0];
Blin=[0;1];
Clin=[1 0];
ys=80;
K=place(Alin,Blin,[-10,-1/10]);

% Teniamo conto che la retroazioe v=-K*z+k1*ys, ma noi abbiamo a
% disposizione x, non z. Devo quindi trasformare x in z, con la
% trasformazione (diffeomorfismo):
% z=T(x)=[h(x);Lf(h(x))]
T=[h;jacobian(h,[x1 x2])*f]

% a questo punto non mi rimane che riportare tutto nello schema simulink



