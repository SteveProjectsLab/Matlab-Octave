clear
close all
clc


dt=0.01;
t=-10:dt:10;

df= 0.01;
f=-15:df:15;  %vettore delle frequenze

x1= rect(t);

X1= T_Fourier(x1, t, f);
plot (f, real(X1));

x_inversa= Inv_T_Fourier(X1, f, t); %ricalcolo il segnale di partenza
plot( t, real(x_inversa));

%%
x2= tri(t);

X2= T_Fourier( x2, t, f);
plot ( f, real(X2));

x2_inversa= Inv_T_Fourier(X2, f, t);
figure
plot ( t, real(x2_inversa));

%%
x3= exp(-pi*t.^2);

X3= T_Fourier( x3, t, f);
plot ( f, real(X3));

x3_inversa= Inv_T_Fourier(X3, f, t);
figure
plot ( t, real(x3_inversa));


%%
%ESERCIZIO 2 - parte 2

x4=cos(4*pi*t);
plot(t, x4)

X4= T_Fourier( x4, t, f);
figure 
plot (f, real(X4),'black') %immagine giustificata dal fatto che il coseno è finestrato tra -10 e 10 ( immagino quindi ci sia un rect che finestra)

%%
%ESERCIZIO 3

T= 2;
h=1/T*rect((t-T/2)/T);

H=T_Fourier(h, t, f);
figure
plot (f, abs(H)), title ('Modulo')
figure
plot(f, angle(H)), title ('Fase')

% plot (f, unwrap(angle(H))); restituisce una fase "srotolata"

%%
%ESERCIZIO 4

fo=0.2;
A=1;
%x= A*cos(2*pi*t);
%h=1/T*rect((t-T/2)/T);
y=zeros(1, length(t)); %calcolo la convoluzione tra x e h

dtau=dt;
tau=-15:dtau:15; %t è la traslazione
for k=1:length(t)
    
    y(k)=integrale(cos(2*pi*fo*tau).*rect((t(k)-tau-T/2)/T)/T, dtau);
end

plot(t, y);

%%
%ESERCIZIO 5 : verfica risposta in frequenza
%y(t) = A|H(f0)| cos (2πf0t+ < H(f0))

%NB: H è un vettore in Matlab -> non posso calcolare H(fo), ma devo trovare
%l'indice della frequenza fo

findex= find(abs(f-fo)<10^(-6)); %per trovare l'indice che permette di avere f=fo ( scrivo così per avere una certa tolleranza)
tindex= find(t==0);

fprintf('Il modulo di H in %f è uguale a %f\n', fo, abs(H(findex))) 
fprintf('Il massino di y(t) è uguale a %f\n\n', max(y))

%Sto confrontando i massimi delle due funzioni per far vedere che sono
%uguali

fprintf('La fase di H in %f è uguale a %f\n', fo,angle(H(findex)))
fprintf('La fase di y(t) è uguale a %f\n', -acos(y(tindex)/max(y)) )

%Sto confrontando le fasi dei due segnali e vedo che sono uguali
