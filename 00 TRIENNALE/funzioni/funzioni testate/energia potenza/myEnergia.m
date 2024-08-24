function y = myEnergia(x,dt)

%VARIABILI
% x = vettore di valori
% dt = passo

%COSA FA 
% energia = integrale(|x^2|)

y=myIntegrale( abs(x).*abs(x),dt);