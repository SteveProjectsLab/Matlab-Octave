clear
close all
clc
%Es.1
%Modellizzazione del sistema
syms X1 X2 u;
%X1: quantità di melange
%X2: quantità vermi delle sabbie
%u: quantità di spezia raccolta
%dx/dt=F(X1,X2)
F=[2*X2-0.1*X1-0.5*u;
   X2-X2^2/100-0.9*X2];
%ingresso di equilibrio
ueq=1;
%calcolo i punti di equilibrio
xeq=solve(subs(F,u,ueq)==0);
xeq1=double([xeq.X1(1),xeq.X2(1)]);
xeq2=double([xeq.X1(2),xeq.X2(2)]);
%calcolo lo Jacobiano
J_s=jacobian(F,[X1,X2]);
%valuto il punto xeq1
J_1=subs(J_s,[X1,X2,u],[xeq1,ueq]);
J_1=double(J_1);
aval1=eig(J_1);
%valuto il punto xeq2
J_2=subs(J_s,[X1,X2,u],[xeq2,ueq]);
J_2=double(J_2);
aval2=eig(J_2);

fprintf('Es.1\n\n');
fprintf('Modello:\n');
fprintf('\tdX1/dt=%s\n\tdX2/dt=%s\n\n',F(1),F(2));
fprintf('Punti di equilibrio:\n');
fprintf('\txeq1: [%f %f]\t autovalori: [%f %f]\t instabile\n',xeq1,aval1);
fprintf('\txeq2: [%f %f]\t autovalori: [%f %f]\t stabile\n',xeq2,aval2);