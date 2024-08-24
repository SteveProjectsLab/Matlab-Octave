function y = myNorm(x, dt)
%MYNORM esegue il modulo della funzione passata in input
y=sqrt((integrale(abs(x).^2, dt)));
end

