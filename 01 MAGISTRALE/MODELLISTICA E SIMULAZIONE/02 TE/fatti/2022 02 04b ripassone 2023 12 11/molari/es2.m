clear
close all
clc

syms x1 x2 u
f=[x1*(0.01*x1-1)+(x1*x2)/50;0.001*(x1*x2)/1000-0.1*x2+u]
y=x1
ueq=0.5;

% calcolo i punti di equilibrio
xeq_s=solve(subs(f,u,ueq)==0)
%xeq1 =     0     5
%xeq2 =   1.0e+05 *    1.0001   -0.4996
%xeq3 =   89.9910    5.0045

% ci sono 3 puntidi equilibrio perchè sono tutti reali

xeq1=double([xeq_s.x1(1) xeq_s.x2(1)])
xeq2=double([xeq_s.x1(2) xeq_s.x2(2)])
xeq3=double([xeq_s.x1(3) xeq_s.x2(3)])

% calcolo la matrice jacobiana e la valuto nei punti di equilibrio

J_s=jacobian(f,[x1 x2])

J1=double(subs(J_s,[x1 x2 u],[xeq1,ueq]));
aval1=eig(J1)
J2=double(subs(J_s,[x1 x2 u],[xeq2,ueq]));
aval1=eig(J2)
J3=double(subs(J_s,[x1 x2 u],[xeq3,ueq]));
aval1=eig(J3)

%aval1 =  -0.1000   -0.9000                 % nodo stabile
%aval1 =   1.0e+03 *    1.0000    0.0001    % nodo instabile
%aval1 =    0.8999   -0.0999                % sella instabile

%##########################################################################
%devo linearizzare attorno a [0 5] % errore nel testo [50] non c'è come
%punto di equilibrio

% linearizzo f e G ( nel nostro caso è y, già lineare), rispetto a x e u 
% per ottenere Alin, Blin, Clin
Alin=J1                    % jacobiana di f calcolata rispetto a [x1 x2], calcolata in xeq1
Blin=double(jacobian(f,u))  
Clin=double(jacobian(y, [x1 x2]))
Dlin=0                     %perchè y non dipende da u

% verifica se il sistema rispetta già la richiesta
% controllare che Alin e Blin sia completamente raggiungibile!!!
Rr=rank(ctrb(Alin,Blin))


% il rango risulta 1 quindi non posso controllare il sistema in retroazione
% dello stato
% k esiste ma non sempre

% Alin =
% 
%    -0.9000         0
%     0.0000   -0.1000

% x1 punto dipende solo da x1, analogamente x2
% la raggiungibilità dipende solo da u, devo avere u in tutte le eq di
% stato

% se u non c'è ho sempre uno dei due stati che è zero, quindi non abbiamo
% completa raggiungibilità

% su x1 siamo spacciati

% NON CALCOLO QUINDI K




% devo calcolare K


% simulo su simulink
x0=[0.1;6];