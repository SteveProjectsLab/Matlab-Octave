function stampa = stampaCoeff_bk_SerieFourier(bk, numero_armoniche)
%STAMPACOEFF_BK_SERIEFOURIER Summary of this function goes here
%   funzione che stampa in coefficienti bk della serie di Fourier con il
%   comando stem
stem(1:numero_armoniche, bk), title (sprintf('b calcolato con l''integrale con %d armoniche', numero_armoniche))
end

