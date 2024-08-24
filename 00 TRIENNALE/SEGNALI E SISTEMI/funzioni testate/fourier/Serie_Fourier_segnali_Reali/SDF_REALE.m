function x_approx_calc = SDF_REALE(x, numero_armoniche, numero_righe, periodo, t, dt)
%CALCOLO_SEGNALEX_REALE_SERIEFOURIER Summary of this function goes here
%   Calcolo un'approssimazione del segnale x REALE con la serie di Fourier,
%   utilizzando i coefficienti ak e bk calcolati con il metodo integrale.

%   NB: con numero righe intendo se voglio calcolare diverse armoniche a
%   ogni ciclo

T=periodo;

Xo=calcolo_x0_reale(x, T, t, dt);

x_approx_calc=zeros(numero_righe, length(t))+ Xo;

for n=1: numero_righe
    

a=calcolo_ak(x, numero_armoniche , periodo, t, dt);
b=calcolo_bk(x, numero_armoniche , periodo, t, dt);

 for k=1: numero_armoniche
        
        x_approx_calc(n, :)= x_approx_calc(n, :) +2*a(k)*cos(2*pi*k/T*t) +2*b(k)*sin(2*pi*k/T*t);
         
 end
 
end


end

