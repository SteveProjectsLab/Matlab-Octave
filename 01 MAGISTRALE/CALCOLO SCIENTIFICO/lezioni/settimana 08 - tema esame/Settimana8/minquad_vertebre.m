% dati problema vertebre minimi quadrati
x =[0;0.04;0.06;0.10;0.14;0.25;0.31];  % vettore colonna
y =[0;0.03;0.08;0.08;0.14;0.20;0.23];
% per risolvere con i minimi quadrati

m=length(x);  % numero dei dati
n=2; % numero di incognite del problema 
% = numero di coefficienti da calcolare

% definisco la matrice X
X=[x, ones(m,1)];

% devo risolvere X'X b= X' y con fattorizzazione QR

% calcolo la fattorizzazione QR di A con il comando matlab
[Q,R]=qr(X);
% estraggo Rtilde e Qtilde
Rtilde=R(1:n,:);  % triangolare superiore
Qtilde=Q(:,1:n);
a=sost_indietro(Rtilde, Qtilde'*y) 
% a contiene i coefficienti della retta di regressione che approssima i
% dati nel senso dei minimi quadrati

%% rappresento graficamente i dati e la soluzione

figure(1); clf
plot(x,y,'or','Markerfacecolor','r')
xlabel('sforzo')
ylabel('deformazione')
grid on

% valuto la retta di regressione nei punti x
yr=polyval(a,x); % valuta il polinomio di coefficienti memorizzati in a
% nei punti di ascissa x

hold on
plot(x,yr,'LineWidth',2)

%% voglio calcolare la deformazione corrispondente ad uno sforzo 
% pari a 0.2

ynew=polyval(a,0.2)
% ynew=a_1*0.2+a_2