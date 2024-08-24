%CORRELAZIONE - CONVOLUZIONE
 
%Cross_correlazione       Phi_xy(tau) = <y(tau),x> = integrale(x*(t) . y(t+tau))
%Auto-correlazione        Phi_x(tau)   = <x(tau),x> = integrale(x*(t) . x(t+tau))

%%
%PER SEGNALI PERIODICI, di periodo T

%Cross-corr Circolare	  Phi_xy(tau) = 1/T . integrale(x*(t) . y(t+tau))
%auto-corr Circolare   	  Phi_x(tau)   = 1/T . integrale(x*(t) . x(t+tau))
%%
%Convoluzione 		      (x*h) (t) = integrale( x(tau) . h(t-tau) )

%%
%proprietà:
%		supporto
%        commutativa
%		associativa
%		distributiva sull’addizione
