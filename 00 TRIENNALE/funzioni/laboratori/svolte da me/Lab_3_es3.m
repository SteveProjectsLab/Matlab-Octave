%convoluzione
   x = rect(tau-2);
% chiamo y il risultato
y=0*t;

 for k = 1:length(t)
    y(k) = integrale(x.*exp(-(t(k)-tau)).*gradino(t(k)-tau),dtau); %attenzione integrale in dtau
 end
 figure(6), plot(t,real(y)), hold on
 plot(t,imag(y),'r--');