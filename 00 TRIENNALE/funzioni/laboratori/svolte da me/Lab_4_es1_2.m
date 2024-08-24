clear
close all
clc

dt = 0.01;      %
t = -10:dt:10;  %vettore dei tempi
df = 0.01;      %
f = -15:df:15;  %vettore delle frequenze

% NB l'esercizio 1 creare funzioni: tdf e tdf inversa
% NB l'esercizio 2 le utilizza

%esercizio2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n\nLAB 4 es 1.1\n\n');
fprintf('\n\nLAB 4 es 2.1\n\n');
%TRASFORMATA DIRETTA e INVERSA

%parte A
x1= rect(t);
X1= myFourier(x1,t,f); %dovrebbe uscire sinc(t)
%figure(1),plot(f,real(X1)),title('X1 rect')
x1_inv= myFourierInv(X1,f,t);
%figure(2),plot(t,real(x1_inv)),title('x1 rect inv') %dovrebbe uscire il rect con fenomeni di gibbs

%parte B
x2= tri(t);
X2= myFourier(x2,t,f); 
%figure(3),plot(f,real(X2)),title('X2 tri')
x2_inv= myFourierInv(X2,f,t);
%figure(4),plot(t,real(x2_inv)),title('x2 tri inv')

%parte C
x3= exp(-1*pi*t.*t);
X3= myFourier(x3,t,f); 
%figure(5),plot(f,real(X3)),title('X3 exp')
x3_inv= myFourierInv(X3,f,t);
%figure(6),plot(t,real(x3_inv)),title('x3 exp inv')

figure('Name','Parte 1: Trasformata diretta e inversa','NumberTitle','off'),set(1, 'WindowStyle', 'docked')
r =3;
c =3;

subplot(r,c,1),plot(t,x1),title('x1 ')
subplot(r,c,2),plot(t,x2),title('x2 ')
subplot(r,c,3),plot(t,x3),title('x3 ')

%subplot(r,c,4),plot(f,imag(X1)),title('X1 tdf Im')
%subplot(r,c,5),plot(f,imag(X2)),title('X2 tdf Im')
%subplot(r,c,6),plot(f,imag(X3)),title('X3 tdf Im')

subplot(r,c,4),plot(f,real(X1)),title('X1 tdf Re')
subplot(r,c,5),plot(f,real(X2)),title('X2 tdf Re')
subplot(r,c,6),plot(f,real(X3)),title('X3 tdf Re')

subplot(r,c,7),plot(t,real(x1_inv)),title('x1 tdf inv')
subplot(r,c,8),plot(t,real(x2_inv)),title('x2 tdf inv')
subplot(r,c,9),plot(t,real(x3_inv)),title('x3 tdf inv')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n\nLAB 4 es 2.2\n\n');
%graficare la tdf del segnale e giustificare il risultato
x4 = cos(4*pi*t);% NB il coseno è finestrato  tra -10 e 10

figure('Name','Parte 2: x4','NumberTitle','off'),set(2, 'WindowStyle', 'docked')
plot(t,real(x4)),title('x4 cos')

X4= myFourier(x4,t,f);

figure('Name','Parte 2: X4','NumberTitle','off'),set(3, 'WindowStyle', 'docked')
plot(f,real(X4)),title('X4 cos')
%mi aspetto due delte di dirac, in +2 e -2
     
    
    