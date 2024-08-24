clear
close all
clc

dt=0.01;
t=-10:dt:10;

df=0.01;
f=-15:df:15;

%%
%ESERCIZIO 1.1
%x1=(t)rect(t/4)*delta4(t);

T=4;
x1=zeros(1, length(t));

%Come rappresentare un segnale periodico
for n = floor(min(t)/T): ceil(max(t)/T)  
 
    x1= x1 + (t-n*T).*rect((t-n*T)/T);
    
    
end

plot(t, x1), title('x1 originale')


%%
%ESERCIZIO 1.2 : Rappresentazione con armoniche

N_Armoniche_Vettore= [10 20 30];
%é un vettore che definisce a quante armoniche sono interessato

x1_approssimato= zeros(length(N_Armoniche_Vettore), length(t)); 
%matrice in cui ogni riga contiene una diversa approssimazione

x1_approssimato_calc= zeros(length(N_Armoniche_Vettore), length(t)); 
%cerco di calcolare io l'approssimazione di x1

for n= 1: length(N_Armoniche_Vettore)
   
    N_Arm=N_Armoniche_Vettore(n);
   
    %identifica quante armoniche sono usate
    
    %CREO I COEFFICIENTI DELLA SERIE DI FOURIER
    b= zeros(1, N_Arm); 
    %b è il vettore dove salvo i TUTTI i coeff.
    
    b_calc=zeros(1,N_Arm); 
    %b_calc è il vettore dove salvo i coeff.
    
    for k=1: N_Arm
        b(k)= (-2/(pi*k))*(-1)^k;
        x1_approssimato(n, :)= x1_approssimato(n, :) + 2*b(k)*sin(2*pi*k/T*t);
         
        %ESERCIZIO 3: calcolo dell'approsimazione con integrale
         
        b_calc(k)= 1/T*integrale(x1.*sin(2*pi*k/T*t).*rect(t/T),dt);
        %.*rect(t/T) serve per finestrare sul periodo
        
        x1_approssimato_calc(n, :)= x1_approssimato_calc(n, :) + 2*b_calc(k)*sin(2*pi*k/T*t);
         
    end
    
    figure
    
    subplot(2,2,1), stem(1:N_Arm, b), title (sprintf('b secondo la formula data con %d armoniche', N_Arm))
    subplot(2,2,2), plot(t, x1_approssimato(n,:), t, x1), title (sprintf('x1 ricostruito con b secondo la forma data con %d armoniche', N_Arm))
    
    subplot(2,2,3), stem(1:N_Arm, b_calc), title (sprintf('b calcolato con l''integrale con %d armoniche', N_Arm))
    subplot(2,2,4), plot(t, x1_approssimato_calc(n,:), t, x1), title (sprintf('x1 ricostruito con b calcolato con l''integrale con %d armoniche', N_Arm))
    
    figure
    
    differenza= x1-x1_approssimato(n,:);
    plot(t, differenza), title(sprintf('Differenza calcolata con %d armoniche', N_Arm))
    
    %Uso stem per stampare segnali discreti
    
    
    
    
end

 %%
 %ESERCIZIO 4: creazione dei segnali con armoniche pari e dispari
 
 x1OddHarmApprox= zeros(1, length(t));
 
 for k=1:2:N_Arm  %prendo tutte le dispari
     
     x1OddHarmApprox= x1OddHarmApprox +2*b(k).*sin(2*pi*k/T*t);
     
     
 end
 

x1EvenHarmApprox= zeros(1, length(t));
 
 for k=2:2:N_Arm  %prendo tutte le pari
     
     x1EvenHarmApprox= x1EvenHarmApprox +2*b(k).*sin(2*pi*k/T*t);
     
end
 
figure 
subplot(3,1,1), plot(t, x1OddHarmApprox), title('Ricostruzione armoniche pari')
subplot(3,1,2), plot(t, x1EvenHarmApprox), title('Ricostruzione armoniche dispari')
subplot(3,1,3), plot(t, x1OddHarmApprox+x1EvenHarmApprox), title('Ricostruzione somma armoniche pari e dispari')


%%
%ESERCIZIO 2

x2= abs(cos(pi/2*t-pi/4));
T=2;

plot(t, x2), title('x2 originale')

N_Armoniche_Vettore=[10 20 30];


X0=2/pi;
X0_calc= 1/T*integrale(x2.*rect(t/T), dt);


x2Approx=zeros(length(N_Armoniche_Vettore), length(t))+ X0;
x2ApproxCalc= zeros(size(x2Approx))+ X0_calc;

for n=1: length(N_Armoniche_Vettore)
    N_Arm=N_Armoniche_Vettore(n);
    
    Xpos=zeros(1,N_Arm);
    Xneg= zeros(1,N_Arm);
    
    Xpos_calc=zeros(1,N_Arm);
    Xneg_calc= zeros(1,N_Arm);
    
    for k=1:N_Arm
        
        Xpos(k)=(-1)^(k+1)*2/(pi*(4*k^2-1))*exp(-1j*pi*k/2);
        Xneg(k)= conj(Xpos(k));
        %oppure prendo la formula del Xpos e metto -k al posto di k
        x2Approx(n,:)= x2Approx(n,:)+ Xpos(k)*exp(1j*2*pi*k/T*t)+ Xneg(k)*exp(-1*2*1j*pi*k/T*t);
        
        
        %ESERCIZIO 3
        
        Xpos_calc(k)= 1/T*integrale(x2.*exp(-1j*2*pi*k/T*t).*rect(t/T),dt);
        Xneg_calc(k)= 1/T*integrale(x2.*exp(1j*2*pi*k/T*t).*rect(t/T),dt);
        
        x2ApproxCalc(n,:)= x2ApproxCalc(n,:)+ Xpos_calc(k)*exp(1j*2*pi*k/T*t)+ Xneg_calc(k)*exp(-1j*2*pi*k/T*t);

    end
    
    figure
    subplot (2, 2, 1)
    stem(-N_Arm:N_Arm, real([Xneg(end:-1:1) X0 Xpos]),'blue')
    %sull'asse x ho i valori che danno tra - e + armonica; 
    %sull'asse y ho i valori dei coefficienti
    hold on
    stem(-N_Arm:N_Arm, imag([Xneg(end:-1:1) X0 Xpos]),'redx --')
    title(sprintf('X secondo le formule con %d armoniche', N_Arm))
    subplot (2,2,2)

    plot(t, x2Approx(n, :)), title (sprintf('x2 ricostruito X secondo la forma data con %d armoniche', N_Arm))

    subplot (2, 2, 3)
    stem(-N_Arm:N_Arm, real([Xneg_calc(end:-1:1) X0_calc Xpos_calc]),'blue'),hold on
    stem(-N_Arm:N_Arm, imag([Xneg_calc(end:-1:1) X0_calc Xpos_calc]),'redx --')
    title(sprintf('X calcolato con l''integrale con %d armoniche', N_Arm))
    subplot (2,2,4)

    plot(t, x2ApproxCalc(n, :)), title (sprintf('x2 ricostruito X calcolato con l''integrale con %d armoniche', N_Arm))

    figure
    plot(t, x2-x2Approx(n,:)), title('Errore')
    
end
