%% risoluzione sistemi lineari
x=A\b
% il comando \ esegue sempre la pivotazione
%% comandi utili
spy(A) 

[Q,R]=qr(A)

colperm(A)
%% fattorizzazione LU + fatt LU con pivotazione
A=[2,3,4;    1,2,1;    3,0,1]
% det(1)  %1
% det([2,0;0,1]) %2
% det(A) % -14
% ho le sottomatrici principali non singolari, posso applicare fatt lu

% senza pivotazione
[L,U]=lu(A)
y=L\b
x=U\y

Aric=L*U   % commetto degli errori

% con pivotazione
[L,U,P]=lu(A)
y=L\(P*b)
x=U\y

%% A non sdp

A=[2,3,4;     1,2,1;    3,0,1]
issymmetric(A)% non è simemtrica
eig(A)% Non ha tutti gli autovalori positivi

% non è quindi sdp
%% A sdp, posso applicare choleshy
A=[20 4 5;4 2 3;5 3 5]

issymmetric(A)% si
eig(A)% ha tutti gli autovalori positivi

% quindi A è simmetrica definita positiva
% posso applicare cholesky

R=chol(A)

Aric=R'*R

%% trovare gli zeri di una funzione
z=fzero(f) % solo per radici reali

%% trasformare anonymous function in symbolic function ( e viceversa)
b=@(t)2500/(1+9*exp(-t/3))

b_s=sym(b)

b1=matlabFunction(b_s)

%% derivate

db=matlabFunction(diff(b_s,1))  % derivata prima

ddb=matlabFunction(diff(b_s,2)) % derivata seconda


%% integrali
syms x
f=1/(1+(x-2)^2) 

I=int(f)        % integrale indefinito            

Idef=int(f,0,2) % integrale definito su [a,b]

% oppure utilizzare l'integrale numerico
I = integral(fun,xmin,xmax)
I=integral(f,0,2,'AbsTol',1.e-5)
%% equazioni differenziali

% edo
syms y(t)
ode = diff(y,t) == t*y
ySol(t)=dsolve(ode) 
%--------------------------------------------------------------------------
% imporre una condizione iniziale

cond = y(0) == 2;  
ySol(t) = dsolve(ode,cond)
%--------------------------------------------------------------------------
% sistema di edo

syms y(t) z(t)
eqns = [diff(y,t) == z, diff(z,t) == -y];
S = dsolve(eqns)
%--------------------------------------------------------------------------
% ridurre il grado dell'edo

syms y(t)
eqn = diff(y,2) + y^2*t == 3*t;
V = odeToVectorField(eqn)
