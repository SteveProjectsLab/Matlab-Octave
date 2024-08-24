% problema di ottimizzazione

syms t % t e' variabile simbolica
b=2500/(1+9*exp(-t/3)); % anche b e' simbolica
b2=diff(b,2); % calcolo b'' simbolicamente
% conversione da funzione simbolica a functionhandle
f=matlabFunction(b2); 

% devo calcolare gli zeri di f con secanti

figure(1); clf
fplot(f, [0,20]);
grid on
xlabel('t')
ylabel('f=b''''(t)')
% dati per secanti
x0=6; x1=8;
tol=1e-8;
kmax=50;
% chiamo secanti
[zero,res,it]=secanti(f,x0,x1,tol,kmax)
%plotto la soluzione
hold on
plot(zero,res,'or','Markerfacecolor','r')


% ottengo
% zero =     6.591673732008660e+00
% res =    -1.421085471520200e-14
% it=5


% il massimo del tasso di crescita si ha dopo circa 6.59 giorni
