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

N_Armoniche_Vettore= [10 20 30];

x1_approssimato_calc= zeros(length(N_Armoniche_Vettore), length(t));

for n= 1: length(N_Armoniche_Vettore)
   
    N_Arm=N_Armoniche_Vettore(n);
   
    x1_approssimato_calc=calcolo_segnaleX_REALE_SerieFourier(x1,N_Arm, length(N_Armoniche_Vettore), T, t, dt);
    
    figure
    
    subplot(3,1,1), stampaCoeff_bk_SerieFourier(calcoloCoefficiente_bk_SerieFourier(x1, N_Arm, T, t, dt), N_Arm)
    subplot(3,1,2), stampaCoeff_ak_SerieFourier(calcoloCoefficiente_ak_SerieFourier(x1, N_Arm, T, t, dt), N_Arm)
    subplot(3,1,3), plot(t, x1_approssimato_calc(n,:), t, x1), title (sprintf('x1 ricostruito con b calcolato con l''integrale con %d armoniche', N_Arm))
    
end

