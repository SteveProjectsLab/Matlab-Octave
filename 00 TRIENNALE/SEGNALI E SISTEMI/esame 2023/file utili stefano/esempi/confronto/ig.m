% funzione per creare un segnale gaussiano

%    x: ig(t) = (1/sqr(2*pi)) * exp(-(t^2)/2)

function g = ig(t)

g = (1/sqrt(2*pi)) * exp(-(t.^2)/2);

% visualizzazione del grafico  
% plot(t,g);
% xlabel("asse dei tempi");
% ylabel("valore della funzione gaussiana");
% title("funzione impulso-gaussiano(t)");
% grid;
% colormap("autumn");
% ylim ([-0.5 1.5]);

% pause;  
% clear
% close all

end