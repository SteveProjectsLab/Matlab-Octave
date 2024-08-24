%CAMPIONAMENTO + INTERPOLATORI         

%x_c(t)= x(t). δ_1/fc (t)
%tc = 1 / fc
	
%	INTERPOLATORE IDEALE 	%h_i (t) = sinc (t / tc)
%	MANTENITORE		%h_m (t) = rect ( (t-tc/2) /tc )
%	INTERPOLATORE IDEALE 	%h_l (t) = tri ( t / tc)

%Ricostruzione x:            %x(t)= x_c(t) ∗ h(t)


%%
%TEOREMA SHANNON + ALIASING  

%TEOREMA DI SHANNON:
% → 	fc >2B     ,dove B è la banda del segnale x  [ NB: la B è il supporto del segnale]avevo segnato banda, sono la stessa cosa?
%		   , fc= frequenza di campionamento

%Se prendessi fc<= 2B :
%NON posso ricavare segnale x di partenza dal segnale campionato, infatti:
%le repliche spettrali si sovrappongono → Presenza di ALIASING


%FILTRO ANTI-ALIASING:
%elimino le parti che si sovrappongono finestrando con un rect opportuno:
%→ rect (f/fc)


