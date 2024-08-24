clear
close all
clc

%Es2
%Modello
syms X1 X2 u v
%X1 X2: variabili del sistema non lineare
%u: ingresso del sistema non lineare
%v: controllo linearizzante (nella variabile Z)

F=[3*(X1^2+X1)*X2;
   -4*X2+X1-X2*u+3*u];
y1=5*X2;
y2=2*X1;

ueq=0;
x0=[3;5];

%calcolo i punti di equilibrio
xeq=solve(subs(F,u,ueq)==0);

xeq1=double([xeq.X1(1) xeq.X2(1)]);
xeq2=double([xeq.X1(2) xeq.X2(2)]);

%calcolo lo Jacobiano
J_s=jacobian(F,[X1 X2]);

%valuto il punto xeq1
J_1=subs(J_s,[X1 X2 u],[xeq1 ueq]);
J_1=double(J_1);
aval1=eig(J_1); %non ho informazioni: ho un autovalore nullo

%valuto il punto xeq2
J_2=subs(J_s,[X1 X2 u],[xeq2 ueq]);
J_2=double(J_2);
aval2=eig(J_2); %instabile: ho un autovalore positivo

%Valuto quale uscita usare per la linearizzazione
%per y1:
%y1 non dipende direttamente da u => r!=0
dy1=jacobian(y1,[X1 X2])*F;
%dy1 dipende direttamente da u => r=1
%r<2 => non posso usare y1 per la linearizzazione
%per y2:
%y2 non dipende direttamente da u => r!=0
dy2=jacobian(y2,[X1 X2])*F;
%dy1 non dipende direttamente da u => r!=1
d2y2=jacobian(dy2,[X1 X2])*F;
%d2y2 dipende direttamente da u => r=2
%r=2 => posso usare y2 per la linearizzazione

%calcolo il controllo linearizzante usando l'uscita y2
f=[3*(X1^2+X1)*X2;
   -4*X2+X1];
g=[0;
  -X2*u+3*u];
h=y2;

u_lin=solve(d2y2==v,u)

%scrivo il sistema dopo la linearizzazione IO (in Z)
A=[0 1;
   0 0];
B=[0;
   1];
C=[1 0];

%calcolo gli autovalori dominanti imponendo T_regime=2s
T_reg=2;
tau=T_reg/5;
a1=-1/tau;
autovalori=[a1;2*a1];

%calcolo la costante k per avere v=-kZ
k=place(A,B,autovalori);

%calcolo il diffeomorfismo che lega X e Z
T=[h;jacobian(h,[X1 X2])*f];

fprintf('Es.2\n\n');
fprintf('Punti di equilibrio:\n');
fprintf('\txeq1: [%f ; %f]\t autovalori: [%f ; %f]\t caso di indecidibilità\n',xeq1,aval1);
fprintf('\txeq2: [%f ; %f]\t autovalori: [%f ; %f]\t instabile\n',xeq2,aval2);
fprintf('Valutazione di y1:\n');
fprintf('\ty1: %s\t non dipende da u => r!=0\n',y1);
fprintf('\tdy1: %s\t dipende da u => r=1\n',dy1);
fprintf('\til grado relativo è minore di 2 => non posso usare y1 per la linearizzazione\n');
fprintf('Valutazione di y2:\n');
fprintf('\ty2: %s\t non dipende da u => r!=0\n',y2);
fprintf('\tdy2: %s\t non dipende da u => r!=1\n',dy2);
fprintf('\td^2y2: %s\t dipende da u => r=2\n',d2y2);
fprintf('\til grado relativo è 2 => uso y2 per la linearizzazione\n');
fprintf('Controllo linearizzante:\n');
fprintf('\tu_lin: %s\n',u_lin);
fprintf('Legge di controllo:\n');
fprintf('\ttempo di regime: %d\t autovalori: [%f ; %f]\n',T_reg,autovalori);
fprintf('\tcostanti k: [%f %f]\n',k);
fprintf('\tdiffeomorfismo: [%s ; %s]\n\n',T);
