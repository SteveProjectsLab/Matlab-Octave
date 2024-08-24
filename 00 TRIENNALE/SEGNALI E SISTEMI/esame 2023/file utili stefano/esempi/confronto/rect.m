% funzione per creare un segnale rettangolare

%                   = 1    con |t|<1/2
%       x: RECT(t)  = 1/2  con |t|=1/2
%                   = 0    con |t|>1/2

function r = rect(t)

r = 1*( abs(t)<1/2 ) + 0.5*( abs(t)==1/2 );

%   % definisco l'asse dei valori, settandolo a zero
%   r = zeros( length(t) );
% 
%   % creo il ciclo per riempire i valori del rect
%   for i = 1 : length(t)
% 
% 	  %creo i valori a t=+-1/2
% 	  if t(i) == 1/2 && t(i) == -1/2
% 		  r(i) = 1/2;
% 
% 	  %creo i valori a t compreso tra +-1/2  
% 	  elseif t(i) > -1/2 && t(i) < 1/2
% 		  r(i) = 1;
% 	
% 	  end
  
%  end

% visualizzazione del grafico  
%plot(t,r);
% xlabel("asse dei tempi");
% ylabel("valore della funzione rect");
% title("funzione rect(t)");
% grid;
% colormap("autumn");
% ylim ([-0.5 1.5]);

% pause;  
% clear
% close all
end