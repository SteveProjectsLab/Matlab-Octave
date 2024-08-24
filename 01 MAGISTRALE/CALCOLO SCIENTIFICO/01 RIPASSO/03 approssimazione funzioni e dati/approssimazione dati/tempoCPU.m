clear
close all
clc

% dati problema CPUtime minimi quadrati
x =(10000:10000:50000)';  % vettore colonna
y =[0.31;0.95; 2.45; 4.10; 6.46];
% per risolvere con i minimi quadrati

m=length(x);  % numero dei dati
n=3; % numero di incognite del problema 
% = numero di coefficienti da calcolare
% cerco una parabola 

%% procedura con la fattorizzazione QR
% definisco la matrice X
X=[x.^2, x, ones(m,1)];

% devo risolvere X'X b= X' y con fattorizzazione QR
% calcolo la fattorizzazione QR di A con il comando matlab
% informat econ
[Qtilde,Rtilde]=qr(X,"econ");
 
a=sost_indietro(Rtilde, Qtilde'*y) 
% a contiene i coefficienti della parabola che approssima i
% dati nel senso dei minimi quadrati


%% calcolo a con il comando polyfit di matlab
% (equivalente alle righe 11-22)
% il terzo argomento e' il grado del polinomio da calcolare
a=polyfit(x,y,2)





%% rappresento graficamente i dati e la soluzione

figure(1); clf
plot(x,y,'bo','Markerfacecolor','b')
xlabel('Lunghezza del vettore')
ylabel('tempo di CPU (sec)')
grid on

% definisco un vettore x1 con piu' punti rispetto a quelli del vettore x,
% solo con lo scopo di disegnare la parabola in maniera piu' fine
x1=linspace(x(1),x(end),100)';
% valuto la parabola nei punti x1
yr=polyval(a,x1); % valuta il polinomio di coefficienti memorizzati in a
% nei punti di ascissa x1

hold on
plot(x1,yr,'LineWidth',2)

%% voglio calcolare il tempo di CPU corrispondente ad una lunghezza L=55218
ynew=polyval(a,55218)
% rappresento il valore trvato sul grafico
plot(55218, ynew,'sg','Markerfacecolor','g')




