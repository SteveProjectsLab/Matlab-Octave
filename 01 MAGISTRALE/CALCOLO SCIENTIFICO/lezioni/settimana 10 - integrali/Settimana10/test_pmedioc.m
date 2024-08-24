% test di pmedioc

% 1 verifico il grado di precisione =1

% considero una funzione di polinomiale di grado 1
% f(x)=2+3x su [1,2]
xa=1; xb=2;
syms x 
fs=2+3*x;
I_ex=int(fs,xa,xb)

% trsformo fs in functionhandle
f=matlabFunction(fs);
%calcolo l'integrale con p.medio composito
Ipm=pmedioc(f,xa,xb,1)


% considero una funzione di polinomiale di grado 2
% f(x)=2+3x+x^2 su [1,2]
syms x 
fs=2+3*x+x^2;
I_ex=int(fs,xa,xb)

% trsformo fs in functionhandle
f=matlabFunction(fs);
%calcolo l'integrale con p.medio composito
Ipm=pmedioc(f,xa,xb,1)

% 2 verifico l'ordine di accuratezza (su una funzione che non e' integrata
% esattamente)
Err=[]; % vettore degli errori al variare di M
H=[]; % il vettore degli H al variare di M
for M=10:2:50
    Ipm=pmedioc(f,1,2,M);
    err=abs(I_ex-Ipm);
    Err=[Err;err];
    H=[H;(xb-xa)/M];
end

% rappresento graficamente gli errori
figure(1); clf
loglog(H,Err,'Linewidth',2,'Displayname','err PMc')
legend('-dynamiclegend')
hold on
grid on
loglog(H,H.^2,'Linewidth',2,'Displayname','H^2')
xlabel('H')
ylabel('errori')


















