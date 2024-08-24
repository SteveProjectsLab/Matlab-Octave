function stampa = stampaCoeff_bk_SerieFourier(coefficente_bk_SerieFourier, numero_armoniche)
%STAMPACOEFF_BK_SERIEFOURIER Summary of this function goes here
%   Detailed explanation goes here
stem(1:numero_armoniche, coefficente_bk_SerieFourier), title (sprintf('b calcolato con l''integrale con %d armoniche', numero_armoniche))
end

