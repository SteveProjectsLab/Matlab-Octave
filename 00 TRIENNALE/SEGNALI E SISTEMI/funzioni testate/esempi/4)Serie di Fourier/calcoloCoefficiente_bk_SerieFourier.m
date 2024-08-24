function bk = calcoloCoefficiente_bk_SerieFourier(x, numero_armoniche , periodo, t, dt)
%CALCOLOCOEFFICIENTE_BK_SERIEFOURIER Summary of this function goes here
%   uso la formula integrale per ricavare i coefficiente bk della serie di Fourier

T=periodo;
b= zeros(1, numero_armoniche);
for k=1: numero_armoniche
   b(k)= (1/T)*integrale(x.*sin(2*pi*(k/T)*t).*rect(t/T), dt);
end

bk=b;

end

