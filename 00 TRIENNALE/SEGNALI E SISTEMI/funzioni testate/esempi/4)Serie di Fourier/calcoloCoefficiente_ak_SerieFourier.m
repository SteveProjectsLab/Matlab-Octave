function ak = calcoloCoefficiente_ak_SerieFourier(x, numero_armoniche , periodo, t, dt)
%CALCOLOCOEFFICIENTE_AK_SERIEFOURIER
%   uso la formula integrale per ricavare i coefficiente ak della serie di Fourier

T=periodo;
a= zeros(1, numero_armoniche);
for k=1: numero_armoniche
   a(k)= (1/T)*integrale(x.*cos(2*pi*(k/T)*t).*rect(t/T), dt);
end

ak=a;

end

