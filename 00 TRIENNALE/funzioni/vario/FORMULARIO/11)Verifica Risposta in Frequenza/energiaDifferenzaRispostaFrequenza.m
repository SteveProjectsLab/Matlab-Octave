function y = energiaDifferenzaRispostaFrequenza(segnale_originale, segnale_troncato, df)
%ENERGIADIFFERENZARISPOSTAFREQUENZA 
%   Calcolo l'energia della differenza tra la riposta all'impulso di un
%   segnale, e il segnale finestrato opportunamente con un rect

differenza=(segnale_troncato- segnale_originale);
y= integrale(abs(differenza).^2, df);

sprintf('L''energia della Differenza tra risposta in frequenza e il segnale troncato è: %f\n', y)
end

