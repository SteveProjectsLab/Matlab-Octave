clear
close all
clc


dt=0.01;
t=-10:dt:10;

dtau=dt;
tau=-15:dtau:15; 

df=0.01;
f=-15:df:15;


%PROBLEMA

%%
%Punto 1
x=tri(t);
h1=sinc(4*t);
h2=(sinc(4*t)).^2;

h=h1+h2;
%poste in serie

y1= zeros(1, length(t)); 
% Convoluzione tra x(t)=tri(t) e h(t)=sinc(4*t)+sinc(4*t).^2

for k= 1:length(t)
   
    y1(k)=integrale(tri(tau).*(sinc(t(k)-4*tau)+(sinc(t(k)-4*tau)).^2), dtau);
    
end

X= T_Fourier(x, t, f);
H= T_Fourier(h, t, f);

y2=Inv_T_Fourier((X.*H),f,t);
%calcolo indiretto 

figure
subplot(2,3,1), plot(t, x), title('Funzione x(t)')
subplot(2,3,2), plot(t, h), title('Funzione h(t)')
subplot(2,3,3), plot(t, y1), title('Funzione y(t), Correlazione')

subplot(2,3,4), plot(f, abs(X)), title('Modulo funzione X(f)')
subplot(2,3,5), plot(f, abs(H)), title('Modulo funzione H(f)')
subplot(2,3,6), plot(t, y2), title('Funzione y, Correlazione')


%%
%Punto 2

T=5;
x_p=zeros(1, length(t));

%Come rappresentare un segnale periodico
for n = floor(min(t)/T): ceil(max(t)/T)  
 
    x_p= x_p + tri(t-n*T);
    
    
end


X_p=T_Fourier(x_p, t, f);
X_c=zeros(1, length(f));

origine= ceil(length(f)/2);

B=2; 
f_campionamento= 2*B; %Frequenza scelta in base al TH. di Shannong
f_sample= mod(origine, f_campionamento):f_campionamento:length(f);   

X_c=zeros(1, length(f));
X_c(f_sample)= X_p(f_sample);
%definisco il segnale campionato attraverso i valori del segnale
%originale in quegli istanti
    
   
x_p1=Inv_T_Fourier(X_c, f, t);

figure
subplot(1,2,1),plot(t, x_p), title('Segnale periodico originale ')
subplot(1,2,2),plot(t, x_p1), title('Segnale periodico ricostruito ')

%%
%Punto 3

bit=3;

x_q=myQuant(x, bit);

errore_quant= x-x_q;

figure
plot(t, x, 'r'), legend('Segnale originale')
hold on
plot(t, x_q, 'b')
hold on
plot(t, errore_quant, 'black')

potenza_media= integrale(errore_quant.^2, dt)/(t(end)-t(1));
fprintf('Potenza media dell''errore di quantizzazione con %dbit : %f\n', bit, potenza_media)


%%
%Quesito 1

z=tri(t);

area=puntomedio(z, dt);
fprintf('L''area del segnale z calcolata con la funzione puntomedio : %f\n', area)

%%
%Quesito 2 -> test funzione Diodo

x1=tri(t);
x2= -tri(t);

figure

subplot(2,3,1), plot(t, x1), title('Segnale x1')
subplot(2,3,2), plot(t, x2), title('Segnale x2')
subplot(2,3,3), plot(t, diodo(x1+x2)), title('Uscita di x1+x2')

subplot(2,3,4), plot(t, diodo(x1)), title('Uscita di x1')
subplot(2,3,5), plot(t, diodo(x2)), title('Uscita di x2')
subplot(2,3,6), plot(t, (diodo (x1)+diodo(x2))), title('Uscita di x1+Uscita di x2')


%%
%Quesito 3 -> test funzione diodo2

z1=exp(-abs(t));

%uscita= diodo2(z1, t);

%figure
%plot(t, uscita);





