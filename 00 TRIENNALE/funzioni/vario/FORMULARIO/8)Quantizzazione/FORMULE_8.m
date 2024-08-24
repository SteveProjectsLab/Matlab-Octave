%QUANTIZZAZIONE
%dinamica= max(x)- min(x)
%∆= dinamica/ 2^(b)
%  = ampiezza dell’intervallo in cui divido l’asse y
%b=numero bit di quantizzazione
%2^(b)= numero livelli

%Errore quantizzazione:           x_quant.(t) - x (t)
%Potenza errore quantizzazione:   ∆²/12
%				              :  integrale( errore² .dt)/ t(fin)- t(in)
