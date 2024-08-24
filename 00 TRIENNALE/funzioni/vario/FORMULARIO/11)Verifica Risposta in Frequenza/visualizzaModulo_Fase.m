function y = visualizzaModulo_Fase(supporto, funzione, nome_funzione_virgolettato )
%VISUALIZZAMODULO_FASE 
%   con supporto indico, a seconda del caso: t, f o tau
%   Permette di visualizzare contemporaneamente Modulo e Fase della funzione

subplot(2,1,1), stampaModulo(supporto, funzione, nome_funzione_virgolettato)
subplot(2,1,2), stampaFase(supporto, funzione, nome_funzione_virgolettato)
end

