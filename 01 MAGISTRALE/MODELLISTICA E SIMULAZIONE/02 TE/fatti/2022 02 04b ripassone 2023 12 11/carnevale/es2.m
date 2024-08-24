clear all

syms u x1 x2
F=[x1*(0.01*x1-1)+(x1*x2)/50;0.001*x1*x2/1000-0.1*x2+u]
y=x1

ueq=0.5;
x0=[0.1;6]
xeq=solve(subs(F,u,ueq)==0)

xeq1=double([xeq.x1(1),xeq.x2(1)])
xeq2=double([xeq.x1(2),xeq.x2(2)])
xeq3=double([xeq.x1(3),xeq.x2(3)])
% tutte le soluzioni del sistema di eq. differenziali sono reali, quindi 
% sono tutte e 3 pti di equilibrio

% xeq1 =
% 
%      0     5
% 
% 
% xeq2 =
% 
%    1.0e+05 *
% 
%     1.0001   -0.4996
% 
% 
% xeq3 =
% 
%    89.9910    5.0045

J_s=jacobian(F,[x1,x2])
J1=double(subs(J_s,[x1,x2,u],[xeq1,ueq]))
J2=double(subs(J_s,[x1,x2,u],[xeq2,ueq]))
J3=double(subs(J_s,[x1,x2,u],[xeq3.ueq]))

aval1=eig(J1) % stabile, nodo stabile
aval2=eig(J2) % instabile, nodo instabile
aval3=eig(J3) % instabile, sella

% aval1 =
% 
%    -0.1000
%    -0.9000
% 
% 
% aval2 =
% 
%    1.0e+03 *
% 
%     1.0000
%     0.0001
% 
% 
% aval3 =
% 
%     0.8999
%    -0.0999

% ATTENZIONE!: punto di equilibrio con x1=50 non c'è. Errore nel testo!!!
% Risolviamo per xeq1=[0 5];
% Linearizzare F e G (nel nostro è y ed è già lineare) rispetto a x e a u
% per ottenere Alin, Blin, Clin. 
% Verificare completa raggiungibilità
% Calcolare K

Alin=J1 % Jacobiana di F rispetto a [x1,x2], calcolata in xeq1
Blin=double(subs(jacobian(F,u),[x1,x2,u],[xeq1,ueq]))
Clin=double(subs(jacobian(y,[x1,x2]),[x1,x2,u],[xeq1,ueq]))
Dlin=0 % perché y non dipende da u

Rr=rank(ctrb(Alin,Blin)) 
% il rango è 1, per cui non posso controllare il sistema con una retroazione dello stato
% non calcolo K


