% funzione per creare un segnale segno

%                   = 1    se t>0
%    x: gradino(t)  = 0    se t=0
%                   = 1    se t<0

function s = segno(t)

s = -1*( t<0 ) + 0*( t==0 ) + 1*( t>0 );

% visualizzazione del grafico  
% plot(t,s);
% xlabel("asse dei tempi");
% ylabel("valore della funzione segno");
% title("funzione segno(t)");
% grid;
% colormap("autumn");
% ylim ([-0.5 1.5]);

% pause;  
% clear
% close all

end