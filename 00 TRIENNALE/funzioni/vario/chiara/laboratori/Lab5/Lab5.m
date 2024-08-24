clear
close all
clc

dt=0.01;
t=-10:dt:10;

df=0.01;
f=-15:df:15;
%%
%ESERCIZIO 1.1
x1=sinc(5*t);
X1=T_Fourier(x1, t, f);
figure 
plot (f, abs(X1), 'red', f, angle(X1), 'black'), legend('Modulo', 'Fase')

x2=sinc(5*(t-1/2));
X2=T_Fourier(x2, t, f);
figure
plot (f, abs(X2), 'red', f, angle(X2), 'black'), legend('Modulo', 'Fase')

x3=sinc(5*(t+1));
X3=T_Fourier(x3, t, f);
figure
plot (f, abs(X3), 'red', f, angle(X3), 'black'), legend('Modulo', 'Fase')

%%
%ESECIZIO 1.2
x4= (sinc(t).^2).*cos(10*pi*t);
X4=T_Fourier(x4, t, f);
X4_calcoltata= 0.5*tri(f-5)+ 0.5*tri(f+5);

subplot(1, 2, 1), plot(f, real(X4)), title( 'Trasformata da matlab'), axis([-10 10 0 1])
subplot(1, 2, 2), plot( f, real(X4_calcoltata)), title('Trasformata Fourier calcolata'), axis([-10 10 0 1])

%NB: sub(a, b, c): mi permette di stampare più funzioni sulla stessa casella
%                 -> a= numero righe in figura
%                 -> b= numero colonne in figura
%                 -> c= indice associato al plot

%NB: , axis([a b c d]) : mi permette di regolare le misure degli assi
%                 -> a= inferiore asse x
%                 -> b= superiore asse x
%                 -> c= inferiore asse y
%                 -> d= superiore asse y

x5= (sinc(t)).*cos(10*pi*t).^2;
X5=T_Fourier(x5, t, f);
X5_calcoltata= 0.25*rect(f+10)+ 0.5*rect(f)+ 0.25*rect(f-10);

subplot(1, 2, 1), plot(f, real(X5)), title( 'Trasformata da matlab'), axis([-10 10 0 1])
subplot(1, 2, 2), plot( f, real(X5_calcoltata)), title('Trasformata Fourier calcolata'), axis([-10 10 0 1])


%%
%ESERCIZIO 2 : Fenomeni di Gibbs

B=2;
h= 2*B*sinc(2*B*t);
H= rect( f/(2*B));

h1= h.*rect(t/4);
H1= T_Fourier(h1,t,f);

h2= h.*rect(t/10);
H2= T_Fourier(h2,t,f);

h3= h.*rect(t/20);  %equivale a h, perchè t va da -10 a 10
H3= T_Fourier(h3,t,f);

figure
subplot(3, 2, 1), plot(t, h1), title ('h1')
subplot(3, 2, 2), plot(f, real(H1)), title ('H1')
 
subplot(3, 2, 3), plot(t, h2), title ('h2')
subplot(3, 2, 4), plot(f, real(H2)), title ('H2')

subplot(3, 2, 5), plot(t, h3), title ('h3')
subplot(3, 2, 6), plot(f, real(H3)), title ('H3')

%Verifico che la sovraelungazione non cambia in base al supporto
fprintf('il massimo di H1 è %f\nIl massimo di H2 è %f\nIl massimo di H3 è %f\n', max(real(H1)), max(real(H2)), max(real(H3)))

%Verifico che l'energia della differenza della risposta in frequenza del sist. ideale e quella del sistema troncato  
%=integrale della H calcolata - H ideale

fprintf('Energia della differenza tra H e H1 è %f\n', integrale(abs(H-H1).^2,df))
fprintf('Energia della differenza tra H e H2 è %f\n', integrale(abs(H-H2).^2,df))
fprintf('Energia della differenza tra H e H3 è %f\n', integrale(abs(H-H3).^2,df))


%%
%ESERCIZIO 3: esempio circuito RC

R=3300;
C=1/1000;
f_taglio= 1/(R*C);

H= 1./(1+ 1j*2*pi*f*R*C); %NB:metto ./ perchè 1+ 1*j*2*pi*f*R*C è un vettore

figure
subplot (2,1,1), plot(f, abs(H)), title('Modulo di H');
subplot (2,1,2), plot(f, angle(H)), title('Fase di H');

%calcolo DIAGRAMMA DI BODE
f_log=f_taglio/100:df:f_taglio*100;
H_log=1./(1+ 1j*2*pi*f_log*R*C);

figure
subplot (2,1,1), loglog(f_log, abs(H_log)), title('Modulo di H');
subplot (2,1,2), semilogx(f_log, angle(H_log)), title('Fase di H');


%loglog -> entrambi gli assi in scala logaritmica
%semilogx/semilogy -> solo uno dei due assi in scala logaritmica

%%
%risposta all'impulso e al gradino

tau=t;
dtau=dt;
h= Inv_T_Fourier(H, f, tau);

y= zeros(1, length(t));

for k=1:length(t)
   
    y(k)=integrale(h.*gradino(-tau+t(k)), dtau);

end

figure
plot(t,real(h)), title('Risposta Impulso')
figure 
plot(t, real(y)), title('Risposta Gradino')
