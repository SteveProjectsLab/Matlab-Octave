function Xk_pos = calcoloCoefficienti_Xk_Positivi_SerieFourier(x, numero_armoniche , periodo, t, dt)
%CALCOLOCOEFFICIENTI_XK_POSITIVI_SERIEFOURIER Summary of this function goes here
%   Calcolo i coefficienti Xk_negativi tramite la formula integrale.
T=periodo;
X_pos= zeros(1, numero_armoniche);

for k=1: numero_armoniche
    
    X_pos(k)= (1/T)*integrale((x.*exp(-1j*2*pi*k/T*t)).*rect(t/T),dt);
    %X(k)= integrale((x.*exp(-1j*2*pi*k/T*t)).*rect(t/T),dt);
    
end

Xk_pos=X_pos;
end


