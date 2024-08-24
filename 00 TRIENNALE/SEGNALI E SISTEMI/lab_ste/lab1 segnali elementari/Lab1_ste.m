% Laboratorio 1 Matlab - 08/03/23

% Inizializzazione
% Cancello tutte le variabili
clear 
% Chiudo tutte le finestre
close all
% Pulisco la finestra di comando
clc

% Asse temporale
dt = 0.01;
t = -10:dt:10;
%-------------------------------------------------------------------------
% *****************
% ** ESERCIZIO 1 ** 
% *****************
%-------------------------------------------------------------------------
fprintf('\nES1 Punto 1\n\n');
fprintf("ES1 disegno i segnali..\n")
% Disegnare nella stessa finestra con colori diversi i seguenti segnali:
%-------------------------------------------------------------------------

x1 = 4*rect((t-3)/10);
x2 = 3*tri((t+1)/4);
x3 = gradino(-t+2);


figure(1), title('Segnali elementari X1 X2 X3'),set(1, 'WindowStyle', 'docked')   % Apre la finestra 1. Se non esiste la crea.
hold on    % Permette di sovrapporre piu' grafici nella stessa finestra.
plot(t,x1), grid on ;
plot(t,x2,'r'),grid on; % L'ultimo parametro specifica il colore da usare.
plot(t,x3,'k'),grid on; % Vedi "help plot" per dettagli.
hold off    % Chiude l'"hold on".
legend('x1','x2','x3');
fprintf("\npremere un tasto per continuare\n")
pause; 
clc
close all
%-------------------------------------------------------------------------
fprintf('\nES1 Punto 2\n\n');
fprintf("compongo i segnali precedenti e li disegno..\n")
% Disegnare nella stessa finestra con colori diversi i seguenti segnali:
%-------------------------------------------------------------------------

x4 = x1+2*x2+3*x3;
x5 = x1.*x2.*x3;

figure(2), title('Segnali elementari X4 X5'),set(2, 'WindowStyle', 'docked')
hold on, grid on
plot(t,x4);
plot(t,x5,'r--'); % Questo comando crea un grafico tratteggiato.

fprintf("\npremere un tasto per continuare\n")
pause; 
clc
close all
%-------------------------------------------------------------------------
fprintf('\nES1 Punto 3\n\n');
fprintf("disegno i segnali..\n")
% Disegnare x6(t) e x7(t) nella stessa finestra con colori diversi e dedurne il periodo. 
% Disegnare x8(t) e x9(t) in altre due finestre. Qual `e il periodo di questi due segnali?
%-------------------------------------------------------------------------

x6 = sin(t);
x7 = cos(2*pi*t);
x8 = x6.*x7;
x9 = x6+x7;

figure(3), set(3, 'WindowStyle', 'docked')
hold on
plot(t,x6,'b'),title('x6'), grid on; 
plot(t,x7,'r'),title('x7'), grid on;
axis([min(t), max(t), -1, 1]); % Imposta gli assi del grafico visualizzato.
hold off
figure(4),set(4, 'WindowStyle', 'docked')
plot(t,x8,'k'),title('x8'), grid on;
figure(5),set(5, 'WindowStyle', 'docked')
plot(t,x9,'g'),title('x9'), grid on;

% Non hanno periodo (somma/prodotto di segnali periodici con periodo in rapporto irrazionale tra loro)

fprintf("\npremere un tasto per continuare\n")
pause; 
clc
close all
%-------------------------------------------------------------------------
% *****************
% ** ESERCIZIO 2 **
% *****************
%-------------------------------------------------------------------------
fprintf('\nES2 Punto 1\n\n');
fprintf("determino la forma analitica..\n")
% Determinare la forma analitica, utilizzando i segnali elementari, del segnale u(t) in figura 1a e scrivere
% il codice che lo realizza. Si utilizzi il finestramento (moltiplicazione per rect(·)).
%-------------------------------------------------------------------------

u = 2*tri(t/2).*rect(t/2);
figure(6),set(6, 'WindowStyle', 'docked')
plot(t,u,'LineWidth',2),title('v'), grid on; % Esempio di manipolazione di proprieta' del grafico.
set(gca,'FontSize',12,'XTick',-2:.5:2,'YTick',[0 1 2]); % Esempio di manipolazione di proprieta' degli assi.
axis([-2 2 -0.1 2])
grid on % Attiva la griglia sulla finestra corrente.

fprintf("\npremere un tasto per continuare")
pause; 
clc
close all

%-------------------------------------------------------------------------
fprintf('\nES2 Punto 2\n\n');
fprintf("determino la forma analitica del segnale sinusoidale..\n")
% Determinare la forma analitica del segnale sinusoidale v(t) in figura 1b e scrivere il codice che lo realizza.
%-------------------------------------------------------------------------

v = -3*cos(pi*t/2);%3*sin(pi*(t-1)/2);
figure(7),set(7, 'WindowStyle', 'docked')
plot(t,v,'LineWidth',2),title('v'), grid on;
set(gca,'FontSize',12,'XTick',-10:10,'YTick',-3:3);
axis([min(t) max(t) -3.1 3.1])

fprintf("\npremere un tasto per continuare\n")
pause; 
clc
close all

%-------------------------------------------------------------------------
fprintf('\nES2 Punto 3\n\n');
fprintf("determino la forma analitica del segnale composto..\n")
% Determinare la forma analitica del segnale composto y(t) in figura 1c e scrivere il codice che lo realizza.
% Fare uso dell’operazione di finestramento dove opportuno.
%-------------------------------------------------------------------------

%
% Versione for/if
%
% y = zeros(size(t));
% for k = 1:length(t)
%     if (t(k)>=-5) && (t(k)<0)3
%         y(k) = 2*sin(2*pi*t(k));
%     elseif (t(k)>=0) && (t(k)<1)
%         y(k) = t(k);
%     elseif (t(k)>=1) && (t(k)<7)
%         y(k) = 1;
%     elseif (t(k)>=7) && (t(k)<8)
%         y(k) = 8-t(k);
%     end
% end

% Versione logica
% y = 2*((t>=-5)&(t<0)).*sin(2*pi*t) + ((t>=0)&(t<1)).*t...
%     + ((t>=1)&(t<7)) + ((t>=7)&(t<8)).*(8-t);

% Versione "finestrata" (una tra le possibili, nella video lezione e' mostrata un'altra possibilita')
y = 2*sin(pi*t).*rect((t+3)/6)+4*tri((t-4)/4)-3*tri((t-4)/3);

figure(8),set(8, 'WindowStyle', 'docked')
plot(t,y,'LineWidth',2),title('y'), grid on;
set(gca,'FontSize',12,'XTick',-10:10);
axis([-10 10 -2.5 2.5])


fprintf("\npremere un tasto per continuare")
pause; 
clc
close all
clear all