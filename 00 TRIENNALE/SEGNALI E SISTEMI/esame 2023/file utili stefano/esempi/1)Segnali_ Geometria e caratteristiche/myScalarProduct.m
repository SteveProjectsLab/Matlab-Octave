function z = myScalarProduct(x,y,dt)
%MYSCALARPRODUCT Summary of this function goes here
%   Detailed explanation goes here
z=integrale(x.*conj(y) ,dt);
end

