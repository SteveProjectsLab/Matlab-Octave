clear
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% approssimazione costante a tratti di un segnale che si ottima in norma quadratica
% la ottengo proiettando il segnale in uno sp. generato dai segnali
% costituenti una base ortonormale

% base di funzioni con k =1...20
% dove fi(k)=rect(t-k+21/2)

dt=0.01;
t=-10:dt:10;
B=zeros(20,length(t));%inizializzo una matrice di dimensione 20
figure(1), set(1, 'WindowStyle', 'docked');
hold on;
for k=1:20
    rectk = rect(t-k+21/2);
    B(k,:)=rectk;% con i due punti predo tutta la k-esima riga
    %assegno alla k-esima posizione la funzione rect traslata
    plot(t,B(k,:)), grid on
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% verificare che la base appena creata sia ortonormale
% calcolo G

G=zeros(20,20);
for k=1:20%prende la funzione base 
    for n=1:20
    G(k,n)=myScalarProduct(B(k,:),B(n,:),dt);%completa riga per riga
    end
end

% G deve essere un'identità
% se osservo sono numeri vicino ad uno sulla diagonale, perchè vi sono
% errori di approssimazione, quindi concludo che è ortonormale


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calcolare la proiezione di x su fi 

x= 10*sin(t).*(1+sqrt(abs(t)));
x2= 10*sin(2*pi*t).*(1+sqrt(abs(t)));
%plot(t,x)
Appr_x=zeros(1,length(t));  %inizializzo a zero
Appr_x2=zeros(1,length(t)); %inizializzo a zero

% costruisco il segnale approssimato
for k=1:20
    ak = myScalarProduct(x,B(k,:),dt);%20 coefficienti alfa
    Appr_x = Appr_x + ak*B(k,:);
end

% lo rappresento in un grafico
E=myEnergia(x-Appr_x,dt)
figure(2),set(2, 'WindowStyle', 'docked');plot(t,x,t,Appr_x),grid on
fprintf('Energia errore: %f\n', myNorm(x-Appr_x,dt).^2)










