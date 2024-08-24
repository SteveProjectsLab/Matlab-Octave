
clc

dt=0.01;
t=-10:dt:10;
B2=zeros(21,length(t));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B2 base non ortogonale data
% costruire matrice B2 come nel 3.1 e G2 come nel 3.2
% verificare che g2 sia non diagonale

% fi2 con k=1,...,21  %dove fik(t)= tri(t-k+11)
% ortogonalizzarla
for k=1:21
    trik = tri(t-k+11);
    B2(k,:)=trik;
end

%G2 nota bene non è diagonale ma tridiagonale

G2=zeros(21,21);
for k=1:21
    for n=1:21
    G2(k,n)=myScalarProduct(B2(k,:),B2(n,:),dt);
    end
end

B2ort = zeros(21,length(t));
B2ort(1,:)=B2(1,:)/myNorm(B2(1,:),dt);
for k = 2:21
    sommatoria = zeros(1,length(t));
    for r = 1:k-1
        sommatoria = sommatoria + myScalarProduct(B2(k,:),B2ort(r,:),dt)*B2ort(r,:);
    end
    v = B2(k,:) - sommatoria;
    B2ort(k,:) = v/myNorm(v,dt);
end
G2ort = zeros(21,21);
for k = 1:21
    for h = 1:21
        G2ort(k,h) = myScalarProduct(B2ort(k,:),B2ort(h,:),dt);
    end
end
Appr_x = zeros(1,length(x));
for k = 1:21
    alpha = myScalarProduct(x,B2ort(k,:),dt);
    Appr_x = Appr_x + alpha*B2ort(k,:);
end
figure(1),set(1, 'WindowStyle', 'docked'),grid on;
plot(t,x,t,Appr_x)
fprintf('Energia errore: %f\n', myNorm(x-Appr_x,dt).^2)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ortogonalizzo B2 con Grand Schmidt
% per poi calcolare la proiezione di x su su questa base

B3=zeros(21,length(t));
B3(1,:)=B2(1,:)/myNorm(B2(1,:),dt); %normalizzo dividendo per a norma 

for k=2:21%salto k =1 come da algoritmo
    sumk = zeros(1,length(t));
    for r=1:k-1
    sumk=sumk + (myScalarProduct(B2(k,:),B3(r,:),dt))*B3(r,:);
    end
    vk=B2(k,:)-sumk;
    B3(k,:)=vk/myNorm(vk,dt);
end
G3=zeros(21,21);
for k=1:21
    for n=1:21
    G3(k,n)=myScalarProduct(B3(k,:),B3(n,:),dt);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% cambiare il segnale e ripetere la prova
x= 10*sin(t).*(1+sqrt(abs(t)));
x2= 10*sin(2*pi*t).*(1+sqrt(abs(t)));
%plot(t,x)
Appr_x=zeros(1,length(t));
Appr_x2=zeros(1,length(t));
for k=1:21
    ak = myScalarProduct(x,B3(k,:),dt);
    Appr_x = Appr_x + ak*B3(k,:);
end
E=myEnergia(x-Appr_x,dt)
figure(2),set(2, 'WindowStyle', 'docked');
plot(t,x2,t,Appr_x),title(''),grid on