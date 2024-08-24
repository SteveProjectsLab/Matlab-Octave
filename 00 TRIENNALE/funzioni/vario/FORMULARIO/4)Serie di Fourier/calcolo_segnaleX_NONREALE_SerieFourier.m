function x_approx_calc = calcolo_segnaleX_NONREALE_SerieFourier(x, numero_armoniche, numero_righe, periodo, t, dt)
%CALCOLO_SEGNALEX_NONREALE_SERIEFOURIER Summary of this function goes here
%  Calcolo un'approssimazione del segnale x NON REALE con la serie di Fourier,
%  utilizzando i coefficienti Xk calcolati con il metodo integrale.

%   NB: con numero righe intendo se voglio calcolare diverse armoniche a
%   ogni ciclo

T=periodo;

Xo=calcoloCoefficiente_Xo_SerieFourier(x, T, t, dt);

x_approx_calc=zeros(numero_righe, length(t))+ Xo;

for n=1: numero_righe
    
Xpos=calcoloCoefficienti_Xk_Positivi_SerieFourier(x, numero_armoniche , T, t, dt);
Xneg=calcoloCoefficienti_Xk_Negativi_SerieFourier(x, numero_armoniche , T, t, dt);

 for k=1: numero_armoniche
        
        x_approx_calc(n, :)= x_approx_calc(n, :) +Xpos(k).*exp(1j*2*pi*k/T*t)+Xneg(k).*exp(-1j*2*pi*k/T*t);
         
 end
 
end
