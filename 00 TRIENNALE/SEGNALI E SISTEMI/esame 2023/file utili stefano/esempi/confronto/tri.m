% funzione per creare un segnale rettangolare

%       x: TRI(t) = 1-|t|  con |t|<1
%                 = 0      con |t|>1

function T = tri(t)
T = (1-abs(t)).*(abs(t)<1);

%   % definisco l'asse dei valori, settandolo a zero
%   T = zeros( length(t) );
% 
%   % creo il ciclo per riempire i valori del tri
%   for i = 1 : length(t)
% 
% 	  %creo i valori a t=+-1
% 	  if abs( t(i) ) <= 1
% 		  T(i) = 1 - abs(t(i));
% 	  end
%   end

% visualizzazione del grafico  
% plot(t,T);
% xlabel("asse dei tempi");
% ylabel("valore della funzione tri");
% title("funzione tri(t)");
% grid;
% colormap("autumn");
% ylim ([-0.5 1.5]);
% 
% pause;  
% clear
% close all

end