dt = 0.01;
t = -10:dt:10;
addpath /Users/nicolatrotti/Desktop/MATLAB/SEGNALI/0.FUNZIONI/

% ******** ESERCIZIO 1 e 2 ********

T = 3;

Er=integrale(rect(t),dt);
Et=integrale(tri(t),dt);
Es=periodicIntegral(sin((2*pi*t)/T),t,T,dt);

fprintf("Energia rect(t): %.2f\n",Er);
fprintf("Energia tri(t): %.2f\n",Et);
fprintf("Potenza sin(2pi*t/3): %.2f\n\n",Es);


x1 = 3*rect(t);
y1 = tri(t);
x2 = y1;
y2 = tri(t-1);
x3 = 2*exp(-abs(t));
y3 = 1j*tri(t);

nomiSegnali = ["x1" "y1" "x2" "y2" "x3" "y3"];
vSegnali = [x1;y1;x2;y2;x3;y3];

vNorma = zeros(1,6);
for i = 1:length(vNorma)
    vNorma(i) = myNorm(vSegnali(i,:),dt);
    fprintf("Norma di %s: %.2f\n",nomiSegnali(i),vNorma(i));
end
fprintf("\n");
vProdScalare = zeros(1,3);
for i = 1:2:6
    vProdScalare(i) = myScalarProduct(vSegnali(i,:),vSegnali(i+1,:),dt);
    fprintf("P.Scalare <%s,%s>: %.2f\n",nomiSegnali(i),nomiSegnali(i+1),vProdScalare(i));
end
fprintf("\n");
vDistanza = zeros(1,3);
for i = 1:2:6
    vDistanza(i) = myDistance(vSegnali(i,:),vSegnali(i+1,:),dt);
    fprintf("Distanza d(%s,%s): %.2f\n",nomiSegnali(i),nomiSegnali(i+1),vDistanza(i));
end

% ******** ESERCIZIO 3 ********

% funzione da approssimare
x = 10*sin(t).*(1+sqrt(abs(t)));
k = 1:1:20;

% inizializzazione matrice con i vettori di base
B=zeros(length(k),length(t));

% riempimento della matrice B coi vettori di base
for i=1:length(k)
    B(i,:) = rect(t-i+21/2);
end

% inizializzazione della matrice G con i prodotti scalari incrociati
G = zeros(length(k),length(k));

% riempimento di G con i prodotti scalari incrociati
for i=1:length(k)
    for j=1:length(k)
        G(i,j) = myScalarProduct(B(i,:),B(j,:),dt);
    end
end

% inizializzazione del vettore dei coefficienti dell'approssimazione ai
% minimi quadrati
a=zeros(1,length(k));

% calcolo dei coefficienti a della proiezione ortogonale di x sulla base B
for i=1:length(k)
    a(i) = myScalarProduct(x,B(i,:),dt);
end

% creazione del vettore approssimazione di x con la base dei rettangoli
x_rect=a*B;

%informazioni sull'energia del segnale reale e quello approssimato
fprintf("Energia seno reale ---> %.2f\n",integrale(x,dt));
fprintf("Energia seno appr  ---> %.2f\n",integrale(x_rect,dt))
fprintf("--------------------------------\n")

% ******** ESERCIZIO 4 **********

k=1:1:21;

% inizializzazione matrice B2 con i vettori di base
B2=zeros(length(k),length(t));

% riempimento di B2 coi vettori di base
for i=1:length(k)
    B2(i,:) = tri(t-i+11);
end

% inizializzazione della matrice G2 con i prodotti scalari incrociati
G2 = zeros(length(k),length(k));

% riempimento di G2 con i prodotti scalari incrociati
for i=1:length(k)
    for j=1:length(k)
        G2(i,j) =  myScalarProduct(B2(i,:),B2(j,:),dt);
    end
end

% ortogonalizzazione della base
B3 = zeros(length(k),length(t));
B3(1,:) = B2(1,:) / myNorm(B2(1,:),dt);
for i = 2:21
    u = B2(i,:);
    for j = 1:i-1
        u = u - myScalarProduct(u,B3(j,:),dt)*B3(j,:);
    end
    B3(i,:) = u / myNorm(u,dt);
end

% inizializzazione della matrice G3 con i prodotti scalari incrociati della
% base ortonormale
G3 = zeros(length(k),length(k));

% riempimento di G3 con i prodotti scalari incrociati
for i=1:length(k)
    for j=1:length(k)
        G3(i,j) = myScalarProduct(B3(i,:),B3(j,:),dt);
    end
end

% inizializzazione del vettore dei coefficienti
a=zeros(1,length(k));

% calcolo dei coefficienti a della proiezione ortogonale di x sulla base B3
for i = 1:length(k)
    a(i) = myScalarProduct(x,B3(i,:),dt);
end

% creazione del vettore approssimazione di x
x_tri=a*B3;

%stampa delle basi
%{
figure(1)
plot(t,B)
pause
figure(2)
plot(t,B2)
pause
figure(3)
plot(t,B3)
pause
%}
%stampa dell'approssimazione di x sulle basi
figure(4)
hold on
plot(t,x,':k',LineWidth=2);
plot(t,x_rect,'r',LineWidth=1.5);
plot(t,x_tri,'b',LineWidth=1.5);
hold off

legend('x','x_rect','x_tri');
title('Segnale reale e sue approssimazioni su due basi differenti');
xlabel('t');


