function stampa = stampaCoeff_ak_SerieFourier(coefficente_ak_SerieFourier, numero_armoniche)
%STAMPACOEFF_AK_SERIEFOURIER Summary of this function goes here
%   Detailed explanation goes here
stem(1:numero_armoniche, coefficente_ak_SerieFourier), title (sprintf('a calcolato con l''integrale con %d armoniche', numero_armoniche))
end

