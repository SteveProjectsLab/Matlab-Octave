function z = myVerificaDistanzaAlQuadrato(x, y, dt)
%MYDISTANZAALQUADRATO Summary of this function goes here
%   Detailed explanation goes here
z= myNorm(x, dt).^2 + myNorm(y, dt).^2 -2*real( myScalarProduct(x, y, dt));
end

