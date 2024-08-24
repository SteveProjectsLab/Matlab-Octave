function Xo = calcoloCoefficiente_Xo_SerieFourier(x, periodo , t, dt)
%CALCOLOCOEFFICIENTE_XO_SERIEFOURIER Summary of this function goes here
%   Calcolo il coefficiente Xo come il valor medio del segnale in un
%   singolo periodo

T=periodo;

Xo= (1/T)*myIntegrale(x.*rect(t/T),dt);

end

