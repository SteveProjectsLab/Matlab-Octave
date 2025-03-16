clear
close all
clc

%% dati problema vertebre minimi quadrati
x =[0;0.04;0.06;0.10;0.14;0.25;0.31];   %sforzo
y =[0;0.03;0.08;0.08;0.14;0.20;0.23];   %deformazione

sigma= 0.2 % valore da stimare dopo aver trovato la retta dei minimi quadrati

% cerco un polinomio di grado 1
% g(x,a)=a1x+a2
% dove x=sigma

%% utilizzo la tecnica dei minimi quadrati
% devo costruire la matrice
m=length(x);    % numero dei dati
n=2;            % numero di incognite del problema 
% = numero di coefficienti da calcolare
X=[x, ones(m,1)];

% % devo risolvere X'X b= X' y con fattorizzazione QR
% [Q,R]=qr(X) % guarda output
% 
% % devo estrarre R tilde e Q tilde
% Rtilde=R(1:n,:);  % triangolare superiore
% Qtilde=Q(:,1:n);
% 
% a=sost_indietro(Rtilde, Qtilde'*y) 
% a=Rtilde\(Qtilde'*y)

% risolvo invece con MAtlab

a=X\y

% a =
%    7.3612e-01
%    1.3928e-02

% a contiene i coefficienti della retta di regressione che approssima i
% dati nel senso dei minimi quadrati

%% rappresento i dati e la loro interpolazione lineare
figure(1)
plot(x,y,'o','MarkerFaceColor','r')

xlabel('sforzo')
ylabel('deformazione')
grid on


yr=polyval(a,x); 
% valuta il polinomio di coefficienti memoizzati in a
% nei punti di ascissa x

hold on
plot(x,yr,'LineWidth',2,'Color','k')



%% voglio calcolare la deformazione corrispondente allo sforzo sigma=0.2

ynew=polyval(a,sigma)
% ynew=a_1*0.2+a_2


% ynew =
%    1.6115e-01