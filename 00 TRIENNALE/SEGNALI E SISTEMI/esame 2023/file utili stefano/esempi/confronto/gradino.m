% funzione per creare un segnale rettangolare

%                   = 1    se t>0
%    x: gradino(t)  = 1/2  se t=0
%                   = 0    se t<0

function g = gradino(t)

g = 0*( t<0 ) + 1/2*( t==0 ) + 1*( t>0 );

% visualizzazione del grafico  
% plot(t,g);
% xlabel("asse dei tempi");
% ylabel("valore della funzione gradino");
% title("funzione gradino(t)");
% grid;
% colormap("autumn");
% ylim ([-0.5 1.5]);

% pause;  
% clear
% close all

end