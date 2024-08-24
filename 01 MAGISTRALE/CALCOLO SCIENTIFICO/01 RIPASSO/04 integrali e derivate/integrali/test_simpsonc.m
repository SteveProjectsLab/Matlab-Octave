% test di simpsonc

% 1 verifico il grado di precisione =3

% considero una funzione di polinomiale di grado 3
% f(x)=2+3x-x^2+5x^3 su [1,2]
xa=1; xb=2;
syms x 
fs=2+3*x-x^2+5*x^3;
I_ex=eval(int(fs,xa,xb))

% trasformo fs in functionhandle
f=matlabFunction(fs);
%calcolo l'integrale con simpson composito
Is=simpsonc(f,xa,xb,5)


%% considero una funzione di polinomiale di grado 4
% f(x)=2+3x+x^2+x^4 su [1,2]
syms x 
fs=2+3*x+x^2+x^4;
I_ex=eval(int(fs,xa,xb))

% trsformo fs in functionhandle
f=matlabFunction(fs);
%calcolo l'integrale con p.medio composito
Is=simpsonc(f,xa,xb,1)

%% 2 verifico l'ordine di accuratezza (su una funzione che non e' integrata
% esattamente)
Err=[]; % vettore degli errori al variare di M
H=[]; % il vettore degli H al variare di M
for M=10:2:50
    Is=simpsonc(f,xa,xb,M);
    err=abs(I_ex-Is);
    Err=[Err;err];
    H=[H;(xb-xa)/M];
end

% rappresento graficamente gli errori
figure(1); clf
loglog(H,Err,'Linewidth',2,'Displayname','err Sc')
legend('-dynamiclegend')
hold on
grid on
loglog(H,H.^4,'Linewidth',2,'Displayname','H^4')
xlabel('H')
ylabel('errori')


















