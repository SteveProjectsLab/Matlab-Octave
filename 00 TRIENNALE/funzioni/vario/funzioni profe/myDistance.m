function ris = myDistance(x,y,dt)

ris = sqrt(integrale(abs(x-y).^2,dt));