function verifica = myVerificaRispostaInFrequenza(y, H, f,  f0, t, precisione)
%MYVERIFICA RISPOSTAINFREQUENZA 
%y(t) = A|H(f0)| cos (2πf0t+ < H(f0))
% H=T_Fourier(h);
%precisione è il numero di decimali che voglio confrontare
%f0 è la frequenza a cui voglio verificare


findex= find(abs(f-f0)<10^(-4));
tindex= find(t==0);

if ( abs( max(y) - abs(H(findex)))< 10^(-precisione))
    verifica1=1;
    fprintf('Il modulo di H in f0 e il massimo della funzione originale coincidono\n\n')
    
    fprintf('Il modulo di H in %f è uguale a %f\n', f0, abs(H(findex))) 
    fprintf('Il massimo di y(t) è uguale a %f\n\n', max(y))
    
else
    verifica1=0;
    fprintf('Il modulo di H in f0 e il massimo della funzione originale NON coincidono\n\n')
end


if ( abs( -acos(y(tindex)/max(y)) - angle(H(findex)))< 10^(-precisione))
    verifica2= 1;
    fprintf('La fase di H in f0 e la fase della funzione originale coincidono\n\n')
    
    fprintf('La fase di H in %f è uguale a %f\n', f0,angle(H(findex)))
    fprintf('La fase di y(t) è uguale a %f\n', -acos(y(tindex)/max(y)) )
    
else
    verifica2=0;
    fprintf('La fase di H in f0 e la fase della funzione originale NON coincidono\n\n')
end

if (verifica1 ==1 && verifica2==1)
    
    fprintf('\nIl Teorema della risposta in frequenza è verificato\n\n')
else
    fprintf('\nIl Teorema della risposta in frequenza NON è verificato\n\n')
end
end

