% Seconda esercitazione di laboratorio
close all
clear
clc

dt = 0.01;
t = -10:dt:10;

% Es.1

en_rect = integrale(abs(rect(t)).^2, dt);
area_rect = integrale(rect(t),dt);
fprintf('Energia rect = %f\n', en_rect)
fprintf('Area rect = %f\n', area_rect)

en_tri = integrale(abs(tri(t)).^2, dt);
area_tri = integrale(tri(t),dt);
fprintf('Energia tri = %f\n', en_tri)
fprintf('Area tri = %f\n', area_tri)

x = sin(2/3*pi*t);
T = 3;
xT = x.*rect(t/T);
pot_sin = integrale(abs(xT).^2,dt)/T;
fprintf('Potenza sinusoide = %f\n', pot_sin)

% Es. 2

x1 = 3*rect(t);
y1 = tri(t);
normx1 = myNorm(x1,dt);
normy1 = myNorm(y1,dt);
distxy = myDistance(x1,y1,dt);
psxy = myScalarProduct(x1,y1,dt);
fprintf('La norma di x1 vale %f\n',normx1)
fprintf('La norma di y1 vale %f\n',normy1)
fprintf('La distanza tra x1 e y1 vale %f\n',distxy)
fprintf('Il prodotto scalare tra x1 e y1 vale %f\n',psxy)
temp = myNorm(x1,dt)^2 + myNorm(y1,dt)^2 -2*real(myScalarProduct(x1,y1,dt));
fprintf('Il valore di temp: %f\n',temp)
fprintf('La distanza al quadrato tra x1 e y1 vale: %f\n',distxy^2)
fprintf('Il modulo del prodotto scalare vale %f, mentre il prodotto delle norme vale %f\n', abs(psxy),normx1*normy1)

% x = 10*sin(t).*(1+sqrt(abs(t)));
x = 10*sin(2*pi*t).*(1+sqrt(abs(t)));
% Es. 3
dim = 20;
B = zeros(dim,length(x));
figure
hold on%tutti i plot che genero li riporto sullo stesso grafico
for k = 1:dim
    B(k,:) = rect(t-k+21/2);
    plot(t,B(k,:))
end
G = zeros(dim,dim);
for k = 1:dim
    for h = 1:dim
        G(k,h) = myScalarProduct(B(k,:),B(h,:),dt);
    end
end
Appr_x = zeros(1,length(x));
for k = 1:dim
    alpha = myScalarProduct(x,B(k,:),dt);
    Appr_x = Appr_x + alpha*B(k,:);
end
figure
plot(t,x,t,Appr_x)
fprintf('Energia errore: %f\n', myNorm(x-Appr_x,dt).^2)

%% Es. 4
dim = 21;
B2 = zeros(dim,length(x));
figure
hold on
for k = 1:dim
    B2(k,:) = tri(t-k+11);
    plot(t,B2(k,:))
end
G2 = zeros(dim,dim);
for k = 1:dim
    for h = 1:dim
        G2(k,h) = myScalarProduct(B2(k,:),B2(h,:),dt);
    end
end
B2ort = zeros(dim,length(t));
B2ort(1,:)=B2(1,:)/myNorm(B2(1,:),dt);
for k = 2:dim
    sommatoria = zeros(1,length(t));
    for r = 1:k-1
        sommatoria = sommatoria + myScalarProduct(B2(k,:),B2ort(r,:),dt)*B2ort(r,:);
    end
    v = B2(k,:) - sommatoria;
    B2ort(k,:) = v/myNorm(v,dt);
end
G2ort = zeros(dim,dim);
for k = 1:dim
    for h = 1:dim
        G2ort(k,h) = myScalarProduct(B2ort(k,:),B2ort(h,:),dt);
    end
end
Appr_x = zeros(1,length(x));
for k = 1:dim
    alpha = myScalarProduct(x,B2ort(k,:),dt);
    Appr_x = Appr_x + alpha*B2ort(k,:);
end
figure
plot(t,x,t,Appr_x)
fprintf('Energia errore: %f\n', myNorm(x-Appr_x,dt).^2)





