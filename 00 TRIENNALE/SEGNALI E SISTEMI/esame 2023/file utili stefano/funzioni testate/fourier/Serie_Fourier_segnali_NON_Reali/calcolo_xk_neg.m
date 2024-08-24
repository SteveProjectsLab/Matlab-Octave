function Xk_neg = calcoloCoefficienti_Xk_Negativi_SerieFourier(x, numero_armoniche , periodo, t, dt)
%CALCOLOCOEFFICIENTI_XK_NEGATIVI_SERIEFOURIER 
%   Calcolo i coefficienti Xk_negativi tramite la formula integrale.

T=periodo;
X_neg= zeros(1, numero_armoniche);


for k=1: numero_armoniche
    
    X_neg(k)= (1/T)*myIntegrale((x.*exp(1j*2*pi*k/T*t)).*rect(t/T),dt);
    %X(k)= integrale((x.*exp(1j*2*pi*k/T*t)).*rect(t/T),dt);
    
end

Xk_neg=X_neg;
end

