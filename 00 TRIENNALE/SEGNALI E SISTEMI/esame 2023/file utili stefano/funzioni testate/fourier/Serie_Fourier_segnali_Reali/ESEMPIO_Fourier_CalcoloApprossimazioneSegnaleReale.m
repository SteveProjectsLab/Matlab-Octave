%Calcolo l'approssimazione del segnale attraverso la Serie di Fourier,
%utilizzando i coefficienti ak e bk

clear
close all
clc

dt=0.01;
t=-10:dt:10;

dtau=dt;
tau=-15:dtau:15;

df=0.01;
f= -15:df:15;

T=4;
x1=zeros(1, length(t));

%Come rappresentare un segnale periodico
for n = floor(min(t)/T): ceil(max(t)/T)  
 
    x1= x1 + (t-n*T).*rect((t-n*T)/T);
    
    
end

plot(t, x1), title('x1 originale')

N_Arm_Vettore= [10 20 30];

x1_appr= zeros(length(N_Arm_Vettore), length(t));

for n= 1: length(N_Arm_Vettore)
   
    N_Arm=N_Arm_Vettore(n);
   
    x1_appr=SDF_REALE(x1,N_Arm, length(N_Arm_Vettore), T, t, dt);
    
    figure
    subplot(3,1,1), stampa_ak(calcolo_ak(x1, N_Arm, T, t, dt), N_Arm)
    subplot(3,1,2), stampa_bk(calcolo_bk(x1, N_Arm, T, t, dt), N_Arm)
    subplot(3,1,3), plot(t, x1_appr(n,:), t, x1), title (sprintf('x1 ricostruito con b calcolato con l''integrale con %d armoniche', N_Arm))
    
end

