% Laboratorio 1 Matlab

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

% *****************
% ** ESERCIZIO 1 **
% *****************

% ********* Punto 1.i **********

x1 = 4*rect((t-3)/10);
x2 = 3*tri((t+1)/4);
x3 = gradino(-t+2);


figure(1)   % Apre la finestra 1. Se non esiste la crea.
hold on     % Permette di sovrapporre piu' grafici nella stessa finestra.
plot(t,x1);
plot(t,x2,'r'); % L'ultimo parametro specifica il colore da usare.
plot(t,x3,'k'); % Vedi "help plot" per dettagli.
hold off    % Chiude l'"hold on".

% ********** Punto 1.ii **********

x4 = x1+2*x2+3*x3;
x5 = x1.*x2.*x3;

figure(2)
hold on
plot(t,x4);
plot(t,x5,'r--'); % Questo comando crea un grafico tratteggiato.

% ********** Punto 1.iii **********

x6 = sin(t);
x7 = cos(2*pi*t);
x8 = x6.*x7;
x9 = x6+x7;

figure(3)
hold on
plot(t,x6,'b'); 
plot(t,x7,'r');
axis([min(t), max(t), -1, 1]); % Imposta gli assi del grafico visualizzato.
hold off
figure(4)
plot(t,x8,'k');
figure(5)
plot(t,x9,'g');

% Non hanno periodo (somma/prodotto di segnali periodici con periodo in rapporto irrazionale tra loro)


% *****************
% ** ESERCIZIO 2 **
% *****************

% ********** Punto 2.i **********

u = 2*tri(t/2).*rect(t/2);
figure(6)
plot(t,u,'LineWidth',2); % Esempio di manipolazione di proprieta' del grafico.
set(gca,'FontSize',12,'XTick',-2:.5:2,'YTick',[0 1 2]); % Esempio di manipolazione di proprieta' degli assi.
axis([-2 2 -0.1 2])
grid on % Attiva la griglia sulla finestra corrente.

% ********** Punto 2.ii **********

v = -3*cos(pi*t/2);%3*sin(pi*(t-1)/2);
figure(7)
plot(t,v,'LineWidth',2);
set(gca,'FontSize',12,'XTick',-10:10,'YTick',-3:3);
axis([min(t) max(t) -3.1 3.1])
grid on

% ********** Punto 2.iii **********
%
% Versione for/if
%
% y = zeros(size(t));
% for k = 1:length(t)
%     if (t(k)>=-5) && (t(k)<0)
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

% Versione "finestrata" (una tra le possibili, nella video lezione è mostrata un'altra possibilità)
y = 2*sin(pi*t).*rect((t+3)/6)+4*tri((t-4)/4)-3*tri((t-4)/3);

figure(8)
plot(t,y,'LineWidth',2);
set(gca,'FontSize',12,'XTick',-10:10);
axis([-10 10 -2.5 2.5])
grid on