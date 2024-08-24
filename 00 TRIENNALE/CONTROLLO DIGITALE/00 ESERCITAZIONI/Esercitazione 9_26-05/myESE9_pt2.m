close all
clear all
clc

Tc= 0.01;
den = conv([1 -0.2],[1 -.01]);
Gzas= tf(1, den, Tc) %è nota

% facendo i calcoli Gcl dovrà avere
% Gcl(1)=1
% Gcl deve avere due poli complessi coniugati in 0,6+-0,2j 

% inserisco Gcl



p1= 0.6 +0.2j;
p2= 0.6 - 0.2j;

Gcl= tf(1, conv([1 -p1], [1 -p2]), Tc);
guadagno =dcgain(Gcl) % vale 5

%MA gcl che cerco deve avere guadagno 1

Gcl=1/guadagno*Gcl
guadagno =dcgain(Gcl) % vale 5

C1= minreal((1/Gzas) * (Gcl/ (1-Gcl)))

%punto due
z= tf('z', Tc);
Gcl= 1/ z^2;

C2= minreal((1/Gzas) * (Gcl/ (1-Gcl))); %Con minreal faccio cancellazione

% punto 3
Gzas = Gzas*(z-3)*(-0.5) % modifico Gzas preservando il guadagno unitario

% ho uno zero instabile, devo fattorizzare

K= 1 % zeri instabili di Gzas
k= 1 %grado relativo di Gzas =(grD-grN)=(2-1)=1
L= 0 %numero di poli instabili
P= 1 %Gzas non ha un pol in uno( a 1 così lo aggiungo)
        % per garantire set point, se li avessi avuti avrei messo 0

% K+k+d=g
% L+P+f=g
% d+1+f=g

% A*X=B
% X= A^-1*B

% riscrivo in forma comoda, esplicito quindi A e b
% d+0f-g=-k-K
% 0d+f-g=-L-P
% d+f-g=-1

A = [1 0 -1;0 1 -1; 1 1 -1] % per righe
B=[-K-k;-L-P;-1]
X=inv(A)*B

d=X(1)
f=X(2)
g=X(3)

% adesso mancano i coefficienti M0.. a...

% Gcl=(1-3z^(-1))z^(-1)*M0 = M0z^(-1)-3M0z^(-2)essendo d=0

% 1-Gcl= (1-z^(-1))*(1+a1z^(-1))= 1-z^(-1)+a1z^(-1)-a1z^(-2)= 
% 1 +(a1-1)z^(-1)-a1z^(-2)

% 1-Gcl= sdfs


% eguaglio i coefficienti dello stesso grado
% ottengo

A=[-1 -1; 3 1]
B=[-1;0]
x=inv(A)*B

M0= x(1) %-0.5
a1 = x(2) % 1.5

%Gcl devo scriverla con M o a, è uguale, lo avevo imposto prima


Gcl=M0*z^(-1)-3*M0*z^(-2)

% controllo il guadagno
guadagno = dcgain(Gcl) % vale effettivamente 1

C3=minreal(1/Gzas*Gcl/(1-Gcl))


