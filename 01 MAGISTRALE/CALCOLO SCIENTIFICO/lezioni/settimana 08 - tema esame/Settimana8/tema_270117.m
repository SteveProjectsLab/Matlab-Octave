% tema d'esame del 27.01.17
A=[324 -45 246 -162 -9;
-45 1048 442 96 113;
246 442 435 -183 30;
-162 96 -183 387 60;
-9 113 30 60 20];

b=[615;
2736;
1838;
-360;
247];

% verifico che A sia sdp
if A'==A
    disp('matrice simmetrica')
% controllo gli autovalori
    v=eig(A)
% criterio di Silvester 
%     sdp=0;
%     for i=1:5
%         Ai=A(1:i,1:i); % sottomatrice 
%         % principale di dim=i
%         deti=det(Ai);
%         if deti<=0
%             disp('matrice non sdp')
%             sdp=1;
%         end
%     end
%     if sdp==0 
%         disp('matrice sdp')
%     end
else
    disp('matrice non simmetrica')
end

%% punto 2
% scelgo la fatt di cholesky perche'.....
R=chol(A); % R e' triang sup
% Ax =b     <==>  R'*R*x = b
% risolvo R'y=b   e' triangolare inferiore (sost. avanti)
% risolvo Rx=y e' tr. superiore (sost. indietro)
y=sost_avanti(R',b);
x=sost_indietro(R,y)

%% risolvo con gradiente e gradiente coniugato

x0=rand(5,1);
tol=1e-8;
kmax=500;
[xg,resg,iterg,resvg]=gradiente(A,b,x0,tol,kmax)
 
% metodo del gc
[xgc,resgc,itergc,resvgc]=gradiente_coniugato(A,b,x0,tol,kmax)

% punto 2.4
figure(1); clf

semilogy((0:iterg)',resvg,'Linewidth',2,'Displayname','gradiente')
legend('-dynamiclegend')
hold on 
semilogy((0:itergc)',resvgc,'Linewidth',2,'Displayname','GC')
grid on
xlabel('iterazione')
ylabel('norma del residuo')

%% punto 2.5
KA=cond(A)
% la matrice e' mal condizionata

% stima dell'errore
stima=KA*eps*2
% stima  e' circa 3e-10
% abbiamo imposto una tolleranza per il test d'arresto di 1e-8
% quindi qui prevale l'errore dettato dalla tolleranza del test d'arresto

% calcolo il rho (fattore di riduzione dell'errore ad ogni passo)
% del metodo del gradiente
rho=(KA-1)/(KA+1)

% rho e' molto vicino a 1 e questo implica che l'errore del metodo del
% gradiente scenda molto lentamente al crescere delle iterazioni
