clear all
close all
clc

dt = 0.01;
t = -10:dt:10;

r=1;
c=3;

figure('Name','Segnali Elementari')

subplot(r,c,1)
plot(t,rect(t))
axis([-2 2 -1 2])
grid on

subplot(r,c,2)
plot(t,tri(t))
axis([-2 2 -1 2])
grid on

subplot(r,c,3)
plot(t,gradino(t))
axis([-2 2 -1 2])
grid on

fprintf("premi un tasto per continuare")
pause;
clear all
close all
clc

% MATRICI E VETTORI
t2=(0:.1:2)     % crea vettore    
t2=(0:.1:2)'    % crea colonna
M=zeros(4,4)-1  % crea mat di 4x4 di -1
A = [3 2 4; -2 3 -1; 4 0 -6; 2 1 0];  
        % spazio (o virgola) separa le colonne
        % punto e virgola separa le righe
A(4,:) = []; % : significa tutta la dimensione corrispondente
A = A'; % trasposta (coniugata)
M=[M zeros(4,1)]% aggiungi colonna a mat  
F=M(:,1)        % seleziona colonna mat
F=M([2 3],:)    % seleziona righe di una mat
F=M(1,:)        % seleziona riga mt
F=M(:,[1 5])    % seleziona colonne di una mat
M(:,5) = []     % cancellare una colonna da una mat
M(1,:) = []     % cancellare una riga da una mat
D = rand(3,3)   % matrice casuale (pdf uniforme tra 0 e 1)

fprintf("premi un tasto per continuare")
pause;
clc

B = zeros(1,3)+2    % vettore, inizializzazione con 2
C = ones(3,1)*3     % vettore, inizializzazione con 3

v1 = B*C       % prodotto righe per colonne: (n,p)*(p,m)=(n,m)
v2 = B.*C'     % prodotto elemento per elemento (in questo caso devo trasporre!)
v3 = C.^2      % elevamento a potenza elemento per elemento
v4 = B+C'      % somma (per definizione) elemento per elemento

disp(v3)        % fa vedere solo il valore

A
B
x=B*A(:,3);     % moltiplicare riga per colonna il vettore B con la terza colonna di A e metterlo in x
fprintf('x vale : %d\n',x);

v=x.^A(2,:)
%v1 = B.*v
diag(A)
size(A)
sum(A) % somma di un vettore o delle colonne di una matrice
sum(sum(A)) % somma di una matrice
abs(A) % valore assoluto
A = int8(A)
A = [A; 1 5 -2]% aggiunta di una riga
A = double([A (2:5)']) % aggiunta di una colonna e cast a double
whos A
E =  [5*rand -3*rand]
floor(E) % arrotondamento all'intero precedente
ceil(E) % arrotondamento all'intero successivo
round(E) % arrotondamento all'intero piu' vicino
mod(E,1) % resto della divisione

fprintf("premi un tasto per continuare")
pause;
clear all
close all
clc

