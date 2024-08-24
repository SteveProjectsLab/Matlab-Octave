%
% Programma tutorial - Ctrl+C interrompe l'esecuzione
%
% Autore: Fabrizio Guerrini - v2.1
%

 
% Help

% help <comando> per aiuto testuale
% doc <comando> per aiuto ipertestuale
% lookfor <parola> cerca le funzioni con "parola" nell'aiuto testuale
 
which tutorial % identificazione file


% Pulizia workspace

clear; % clear <nomevar> per cancellare solo la variabile nomevar
%return; % termina l'esecuzione dello script (o della funzione)


% Assegnamento esplicito

A = [3 2 4; -2 3 -1; 4 0 -6; 2 1 0]; % spazio (o virgola) separa le colonne
    % punto e virgola separa le righe
A(4,:) = []; % : significa tutta la dimensione corrispondente
    % in questo caso tutta la quarta riga viene eliminata
A = A'; % trasposta (coniugata)
save; % salvataggio workspace (A) in matlab.mat
pause; % attende la pressione di un tasto
clear;


% Assegnamento implicito

t = -10:.1:10; % vettore da -10 a 10 spaziato di 0.1
t1 = -100:100; % vettore da -100 a 100 spaziato di 1
B = zeros(1,3)+2; % inizializzazione con 0
C = ones(3,1)*3; % inizializzazione con 1
D = rand(3,3); % matrice casuale (pdf uniforme tra 0 e 1)


% Visualizzazione - 1

t % echo della variabile
t1
pause;


% Esercizio (visualizzare le variabili con l'echo):

% 1) generare un vettore COLONNA t2 che va da 0 a 2 con passo 0.1;

t2 = (0:.1:2)';

% 2) generare una matrice E quadrata 4x4 con ogni elemento pari a -1;

E = zeros(4,4)-1;
%E = -ones(4);

% 3) aggiungere una quinta colonna alla matrice E tutta nulla;

E = [E zeros(4,1)];

% 4) definire la matrice F come la seconda e la terza riga di E;

F = E([2 3],:);

% 5) cancellare da F la prima colonna.

F(:,1) = [];



% *********************************************************************


% Operazioni vettoriali ed elemento per elemento

v1 = B*C; % prodotto righe per colonne: (n,p)*(p,m)=(n,m)
v2 = B.*C'; % prodotto elemento per elemento
v3 = C.^2; % elevamento a potenza elemento per elemento
v4 = B+C'; % somma (per definizione) elemento per elemento
% help ops


% Visualizzazione - 2

clc; % pulizia dello schermo
v1
v2
disp(v3) % solo valore
pause;
fprintf('v1 = %d\nPremere un tasto...\n',v1); % output formattato
pause;
clear;
load; % lettura workspace (A) da matlab.mat
B = zeros(1,3)+2;


% Esercizio:

% 1) Moltiplicare riga per colonna il vettore B con la terza colonna di A e metterlo in x

x = B*A(:,3);

% 2) Visualizzare la seguente riga: "x vale : " seguito dal valore di x (usare fprintf)

fprintf('x vale : %d\n',x);

% 3) Creare il vettore colonna v definito da x elevato alla seconda riga di A

v = x.^A(2,:);

% 4) Visualizzare v usando disp

disp(v)

% 5) Creare v1, moltiplicando B e v elemento per elemento, visualizzandolo direttamente
%    (togliendo il punto e virgola)

v1 = B.*v




% *********************************************************************


% Comandi vari per la manipolazione di matrici

A
A(2,2) % estrazione di un elemento da una matrice
pause;
A(:,3) % estrazione di una colonna da una matrice
pause;
A(1,:) % estrazione di una riga di una matrice
pause;
diag(A) % diagonale di A (quadrata)
pause;
A+eye(3) % eye=matrice identita
pause;
size(A) % dimensioni (righe/colonne/...) di A (sia per vettori che per matrici)
pause;
length(B) % lunghezza del vettore B
pause;
sum(A) % somma di un vettore o delle colonne di una matrice
sum(B)
pause;
sum(sum(A)) % somma di una matrice
pause;
abs(A) % valore assoluto
pause
A = int8(A) % cast - help datatypes
whos A % tipo della variabile
A = [A; 1 5 -2] % aggiunta di una riga
pause;
A = double([A (2:5)']) % aggiunta di una colonna e cast a double
whos A
E =  [5*rand -3*rand]
pause;
floor(E) % arrotondamento all'intero precedente
ceil(E) % arrotondamento all'intero successivo
round(E) % arrotondamento all'intero piu' vicino
mod(E,1) % resto della divisione
pause;

% *********************************************************************

% Cicli, condizionali e operazioni logiche

clear;
a = [3:7 4:2:8 3:-1:-1 2:4];
b = 5;
for i = 1:length(a)
    fprintf('Ora guardo %.2f... ',a(i));
    
    if b<0 || a(i)<0
        fprintf('trovato valore negativo! Adios!\n');
        break
    end % break if you find negative values
    
    if i>=2 && a(i)<a(i-1)
        fprintf('E'' decresciuto! Lo salto!\n');
        continue
    end % skip this i if a is decreasing
    
    if a(i)<b
        fprintf('%.2f e'' piu'' grande di %.2f\n',b,a(i));
    elseif a(i)>b
        fprintf('%.2f e'' piu'' piccolo di %.2f\n',b,a(i));
    else % a(i)==b
        fprintf('%.2f e'' uguale a %.2f\n',b,a(i));
    end
end

% Esercizio

% Trasformare il ciclo for in un ciclo while, l'output deve essere
% identico.

fprintf('Versione while\n');
i = 0;
while i<length(a)
    i = i+1;
    fprintf('Ora guardo %.2f... ',a(i));
    
    if b<0 || a(i)<0
        fprintf('trovato valore negativo! Adios!\n');
        break
    end % break if you find negative values
    
    if i>=2 && a(i)<a(i-1)
        fprintf('E'' decresciuto! Lo salto!\n');
        continue
    end % skip this i if a is decreasing
    
    if a(i)<b
        fprintf('%.2f e'' piu'' grande di %.2f\n',b,a(i));
    elseif a(i)>b
        fprintf('%.2f e'' piu'' piccolo di %.2f\n',b,a(i));
    else % a(i)==b
        fprintf('%.2f e'' uguale a %.2f\n',b,a(i));
    end
end
pause;

% *********************************************************************

% Function -> lucidi Lab0-pres1

% *********************************************************************

% Segnali

clear;
clc;
fprintf('Parte segnali\n');
t = -10:.1:10;
x = 5*(sin(t).^2)+1; % x(t) = 1+5sen^2(t)


% Grafici

plot(t,x,'r'); % red - se non ci sono finestre aperte, la apre (figure(1))
pause;
hold on; % mantieni grafico sulla stessa finestra senza cancellare il precedente
plot(t,5*sin(t)+1); % blue
axis tight % assi stretti sul grafico
%axis([min(t) max(t) min(x)-1 max(x)+1]) % assi [minx maxx miny maxy]
hold off;
pause
figure(2) % seleziona una finestra, la seconda (nel caso la apre)
plot(t,t.^2,'k*');
pause;
figure % apre una nuova finestra (diventa la terza)
plot([0 0 1 1],[-2 2 -2 2],'c--')
axis([-1 2 -3 3])
pause;
close; % chiude la finestra corrente (la terza)
pause;
close all; % chiude tutte le finestre
plot(t,[x;t.^2]);
%plot(t,x,'r',t,t.^2,'k');
pause;
clear
close all
clc;


% Segnale rect - versione con ciclo

t = -10:.1:10;
x1 = zeros(size(t));
for i = 1:length(t) 
    if t(i)>-0.5 && t(i)<0.5
        x1(i) = 1;
    elseif abs(t(i))==0.5
        x1(i) = 0.5;
    %else x1(i) = 0;
    end
    %if t(i)>0.5
    %    break;
    %else
    %    continue;
    %end
    %fprintf('QUI!\n');
end
plot(t,x1);
pause;
close all
clear

% Esercizio:

% 1) Copiare il codice del segnale rect in una funzione rect.m

% 2) Costruire le funzioni tri.m e gradino.m


% *********************************************************************

% Indirizzamento logico -> lucidi Lab0-pres2

% *********************************************************************

% Segnale rect - versione con operazioni logiche 
t = -10:.1:10;
x2 = 0.5*(abs(t)==0.5) + (abs(t)<0.5);
figure
plot(t,x2,'r');
pause;
close all
clear

% Esercizio:

% Aggiungere la versione con operazioni logiche a tri.m e gradino.m


