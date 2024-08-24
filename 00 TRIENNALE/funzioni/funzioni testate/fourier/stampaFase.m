function y= stampaFase(supporto, funzione, nome_funzione_virgolettato)
%STAMPAFASE 
%   con supporto indico, a seconda del caso: t, f o tau
plot (supporto, angle(funzione)), title (sprintf('Fase della funzione %s', nome_funzione_virgolettato))
end

