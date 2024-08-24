function A = myNorm(x,dt)

A = sqrt(integrale(abs(x).^2,dt));
% A = sqrt(myScalarProduct(x,x,dt));