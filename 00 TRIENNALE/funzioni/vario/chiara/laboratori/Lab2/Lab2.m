clear
close all
clc


dt=0.01;
t=-10:dt:10;

%NB: per fare il modulo del segnale uso abs()

area1= integrale(rect(t), dt); %usando il ; viene solo svolta l'operazione
energia1 = integrale(abs((rect(t).^2)), dt);
area2= integrale(tri(t), dt);
energia2= integrale(abs((tri(t).^2)), dt);
fprintf('Energia del rect: %f\n', energia1)
fprintf('Area del rect: %f\n', area1)
fprintf('\n');
fprintf('Energia del tri: %f\n', energia2)
fprintf('Area del tri: %f\n', area2)

fprintf('\n');
%CALCOLO POTENZA SINUSOIDE:
%Finestro un periodo della sinusoide usando il rect, poi calcolo
%l'integrale della funzione riquadrata e divido il tutto per il periodo
%[potenza_sinusoide=(1/periodo)*integrale(abs( sinusoide.*rect(t/periodo)).^2, dt)]

s= sin((2/3)*pi*t);
T=3; %periodo della sinusoide
sT= s.*rect(t/T); %prendo solo un periodo della sinusoide
potenza_sin= integrale(abs(sT).^2,dt)/T;
fprintf('La potenza della sinusoide: %f\n', potenza_sin);

fprintf('\n')
%%
%ES.2: calcolo Norma e Distanza

x1= 3*rect (t) ; 
y1= tri (t);
norma1= myNorm(x1, dt);
norma2= myNorm(y1, dt);
fprintf('La norma del segnale x1: %f\n', norma1)
fprintf('La norma del segnale y1: %f\n', norma2)
distanza= myDistance(x1, y1, dt);
fprintf('La distanza tra i due segnali: %f\n', distanza)
prod_scalare= myScalarProduct(x1,y1, dt);
fprintf('Il prodotto scalare tra i due segnali: %f\n',prod_scalare)
verifica= myVerificaDistanzaAlQuadrato(x1, y1, dt);
fprintf('La distanza al quadrato effettiva: %f\n',distanza.^2)
fprintf('La distanza al quadrato stimata: %f\n',verifica)
% VERIFICA DELL'UGUAGLIANZA DI SHWARZ:
fprintf('Il modulo del prodotto: %f\nIl prodotto dei moduli: %f\n',abs(prod_scalare), norma1*norma2)

fprintf('\n')
%%
%ES.3: approssimazione funzione

dim=20;

x=10*sin(t).*(1+sqrt(abs(t)));  
%NB: uso .* per moltiplicare 2 segnali!!

%punto A) creazione matrice con 20 funzioni per approssimare
B=zeros(dim,length(x));  
%NB: deve avere la stessa lunghezza del segnale, perchè poi dovrò operare
%delle moltiplicazioni!!

hold on  % mi fa stampare più funzioni tutte sullo stesso disegno

for k=1:dim    % f= rect(t - k + 21/2)
   
    B(k,:)= rect(t - k + 21/2);
    %NB: metto B(k,:) perchè il comando deve essere valido in tutte le
    %colonne, quindi uso i :
    
    plot(t,B(k,:))  % stampa tutte le funzioni contenute nella matrice
   
end

%punto B) calcolo matrice G dei prodotti scalari tra gli elementi di B

G=zeros(dim, dim);

for k=1:dim
    for h=1:dim
        
        G(k,h)= myScalarProduct(B(k,:), B(h,:), dt);
        %assegno ad ogni elemento di G il valore del prodotto scalare tra
        %la prima funzione fissata B(k,:) e la seconda funzione B(h,:) che
        %itera grazie al 2° ciclo for
        
    end
end

%punto C) calcola proiezione di x su Phi e segnale x approssimato

Appr_x=zeros(1, length(x));

for k=1:dim
   
    alpha= myScalarProduct(x, B(k,:),dt);
    Appr_x= Appr_x + alpha*B(k,:);
    
    %Crea una funzione a gradini che approssima la funzione originale
    
end

figure
plot( t, Appr_x, t, x)  %stampo entrambi i segnali per confrontarli

fprintf('Energia errore di approssimazione: %f\n', myNorm((x-Appr_x), dt).^2);

%%
%ES 4: calcolo approssimazione base NON ortonormale + ORTONORMALIZZAZIONE Gram-Schmidt



dim2=21;

B2=zeros(dim2, length(x));

figure   %crea un nuovo grafico su cui stamapare la funzione BASE
hold on
for k=1:dim2
    
    B2(k,:)= tri( t-k+11);  
    
end
plot (t, B2)

G2= zeros(21, 21);

%Creo la Matrice G2 -> se B2 fosse ortogonanale, G2 sarebbe la matrice I
for k=1:dim2
    for h=1:dim2
        
        G2(k,h)= myScalarProduct(B2(k,:), B2(h,:), dt);
       
    end
end
 
%Ortogonormalizzo con Gram-Schmidt
B2ort=zeros(dim2, length(x)) ;


for k=1:dim2
    
    if(k==1)
        B2ort(k,:)= B2(k,:)/myNorm(B2(k,:), dt);
    else
        sommatoria=zeros(1, length(x));
        for r=1:k-1
            
            sommatoria= sommatoria + myScalarProduct(B2(k,:),B2ort(r,:) ,dt)*B2ort(r,:);
            
        end
        
        v= B2(k,:)- sommatoria;
        B2ort(k,:)= v/myNorm(v, dt);
    end
        
end

%Verifico ora che la metrice G2ort creata con B2ort è uguale a I
G2ort= zeros(21, 21);

for k=1:dim2
    for h=1:dim2
        
        G2ort(k,h)= myScalarProduct(B2ort(k,:), B2ort(h,:), dt);
       
    end
end

%Approssimo x con la base B2ort
Appr2_x=zeros(1, length(x));

for k=1:dim2
   
    alpha= myScalarProduct(x, B2ort(k,:),dt);
    Appr2_x= Appr2_x + alpha*B2ort(k,:);
    
    %Crea una funzione a gradini che approssima la funzione originale
    
end

figure
plot( t, Appr2_x, t, x)  %stampo entrambi i segnali per confrontarli

fprintf('Energia errore di approssimazione: %f\n', myNorm((x-Appr2_x), dt).^2);


%%
%prova

dim2=21;

B2=zeros(dim2, length(x));

figure   %crea un nuovo grafico su cui stamapare
hold on
for k=1:dim2
    
    B2(k,:)= tri( t-k+11);  
    
end
plot (t, B2)
G2= zeros(21, 21);

for k=1:dim2
    for h=1:dim2
        
        G2(k,h)= myScalarProduct(B2(k,:), B2(h,:), dt);
       
    end
end
 
B2ort=myGramSchmidtApproximation(B2,dim2,x, dt) ;
G2ort= zeros(21, 21);

for k=1:dim2
    for h=1:dim2
        
        G2ort(k,h)= myScalarProduct(B2ort(k,:), B2ort(h,:), dt);
       
    end
end

Appr2_x=zeros(1, length(x));

for k=1:dim2
   
    alpha= myScalarProduct(x, B2ort(k,:),dt);
    Appr2_x= Appr2_x + alpha*B2ort(k,:);
    
    %Crea una funzione a gradini che approssima la funzione originale
    
end

figure
plot( t, Appr2_x, t, x)  %stampo entrambi i segnali per confrontarli

fprintf('Energia errore di approssimazione: %f\n', myErroreApprossimazione(x, Appr2_x, dt));

