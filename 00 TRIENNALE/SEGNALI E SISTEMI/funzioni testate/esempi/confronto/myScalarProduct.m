function f = myScalarProduct(x,y,dt)
    f = integrale(x.*conj(y),dt);
end