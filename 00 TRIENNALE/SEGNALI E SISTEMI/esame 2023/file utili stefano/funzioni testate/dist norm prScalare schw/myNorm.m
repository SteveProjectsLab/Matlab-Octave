function y = myNorm(x,dt)

%VARIABILI
% x = vettore di valori
% dt = passo

%COSA FA 
% norma =sqrt(<x,x>)=d2(x,0) = sqrt(energia(x))

y=sqrt(myEnergia(x,dt));
