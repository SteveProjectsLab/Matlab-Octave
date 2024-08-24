%% SDF
%Provo a calcolare l'approssimazione del segnale tramite la Serie di Fourier
%utilizzando i coefficenti Xk

clear
close all
clc

dt=0.01;
t=-10:dt:10;

dtau=dt;
tau=-15:dtau:15;

df=0.01;
f= -15:df:15;

T=3;
x1=zeros(1, length(t));

for n = floor(min(t)/T): ceil(max(t)/T)  
     x1= x1 + 4*rect((t-n*T));
end

plot(t, real(x1), 'black'), title('x1 originale')
hold on
plot(t, imag(x1), 'r--'), title('x1 originale')

N_Armoniche_Vettore= [1 2 3 4 5 10 20 100];

x1_approssimato_calc= zeros(length(N_Armoniche_Vettore), length(t));

for n= 1: length(N_Armoniche_Vettore)
   
    N_Arm=N_Armoniche_Vettore(n);
   
    x1_approssimato_calc=SDF_NON_REALE(x1,N_Arm, length(N_Armoniche_Vettore), T, t, dt);
    
    figure(n)
    
    plot(t,( x1_approssimato_calc(n,:)), 'r', t, (x1), 'black'), title (sprintf('x1 ricostruito con i coefficienti Xk con %d armoniche', N_Arm))
    grid on,set(n, 'WindowStyle', 'docked');
end