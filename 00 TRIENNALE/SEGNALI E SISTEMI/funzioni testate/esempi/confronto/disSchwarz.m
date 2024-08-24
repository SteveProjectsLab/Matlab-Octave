function disSchwarz(x,y,dt)
    if(abs(myScalarProduct(x,y,dt)) <= myNorm(x,dt)*myNorm(y,dt))
        fprintf("Disugaglianza di Schwarz verificata");
    else
        fprintf("Disugaglianza di Schwarz non verificata");
    end
end