function y= stampaModulo (supporto, funzione, nome_funzione_virgolettato)
%STAMPAMODULO
%   con supporto indico, a seconda del caso: t, f o tau
plot (supporto, abs(funzione)), title (sprintf('Modulo della funzione %s', nome_funzione_virgolettato))
end

