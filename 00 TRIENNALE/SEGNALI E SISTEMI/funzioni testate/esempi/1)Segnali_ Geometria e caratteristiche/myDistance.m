function z = myDistance(x,y, dt)
%MYDISTANCE calcola la distanza tra x e y

z=myNorm((x-y), dt);

% =sqr(integrale(abs(x-y).^2,dt));

end

