clear
close all
clc

%Es2
syms X1 X2 u v;

F=[(X1^2+X1)*X2;
   -4*X2+X1-X2*u+3*u];
y=5*X1;

ueq=0;
x0=[3;5];

%calcolo i punti di equilibrio
xeq=solve(subs(F,u,ueq)==0);

xeq1=double([xeq.X1(1) xeq.X2(1)]);
xeq2=double([xeq.X1(2) xeq.X2(2)]);

%calcolo lo Jacobiano
J_s=jacobian(F,[X1,X2]);

%valuto il punto di equilibrio xeq1
J_1=subs(J_s,[X1 X2 u],[xeq1 ueq]);
J_1=double(J_1);
aval1=eig(J_1); %ho un autovalore nullo => indecidibilità

%valuto il punto di equilibrio xeq2
J_2=subs(J_s,[X1 X2 u],[xeq2 ueq]);
J_2=double(J_2);
aval2=eig(J_2); %ho un autovalore positivo => instabile

%valuto il grado relativo del sistema
f=[(X1^2+X1)*X2;
   -4*X2+X1];
g=[0;
   X2+3];
h=y;
%h non dipende direttamente da u => r!=0
dh=jacobian(h,[X1 X2])*F;
%dh non dipende direttamente da u => r!=1
d2h=jacobian(dh,[X1 X2])*F;
%d^2h dipende direttamente da u => r=2

%calcolo l'ingresso linearizzante
u_lin=solve(d2h==v,u);

%sistema ilnearizzato dZ=AZ+Bu
A=[0 1;
   0 0];
B=[0
   1];
C=[1 0];

%calcolo gli autovalori per avere un tempo di regime pari a 2 secondi
T_reg=2;
tau=T_reg/5;
a=-1/tau;
autovalori=[a;2*a];
k=place(A,B,autovalori);

%calcolo il diffeomorfismo che lega Z a X
T=[h;jacobian(h,[X1 X2])*f];

fprintf('Es.2\n\n');
fprintf('Punti di equilibrio:\n');
fprintf('\txeq1: [%f ; %f]\t autovalori: [%f ; %f]\t caso di indecidibilità\n',xeq1,aval1);
fprintf('\txeq2: [%f ; %f]\t autovalori: [%f ; %f]\t instabile\n',xeq2,aval2);
fprintf('Controllo linearizzante:\n');
fprintf('\tu_lin: %s\n',u_lin);
fprintf('Legge di controllo:\n');
fprintf('\ttempo di regime: %d\t autovalori: [%f ; %f]\n',T_reg,autovalori);
fprintf('\tcostanti k: [%f %f]\n',k);
fprintf('\tdiffeomorfismo: [%s ; %s]\n\n',T);