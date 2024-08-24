clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 1-2-3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% costruire funzioni: norma, prodotto scalare, distanza

% verificare le formule di distanze, norme e prodotto scalari
% utilizzando le funzioni appena create

x1=3*rect(t);
x2=tri(t);
x3=2*exp(-abs(t));
y1=tri(t);
y2=tri(t-1);
y3=1i*tri(t);

normx1=myNorm(x1,dt);
normy1=myNorm(y1,dt);
normx2=myNorm(x2,dt);
normy2=myNorm(y2,dt);
normx3=myNorm(x3,dt);
normy3=myNorm(y3,dt);
psx1y1=myScalarProduct(x1,y1,dt);
psx2y2=myScalarProduct(x2,y2,dt);
psx2y2=myScalarProduct(x3,y3,dt);

d1=myDistance(x1,y1,dt);
fprintf('La norma di x1 vale %.2f\n',normx1)
fprintf('La norma di y1 vale %.2f\n',normy1)
fprintf('La distanza tra x1 e y1 vale %.2f\n',d1)
fprintf('Il prodotto scalare tra x1 e y1 vale %.2f\n',psx1y1)
%fprintf('Il valore di temp: %f\n',temp)
%fprintf('La distanza al quadrato tra x1 e y1 vale: %f\n',distxy^2)
%fprintf('Il modulo del prodotto scalare vale %f, mentre il prodotto delle norme vale %f\n', abs(psxy),normx1*normy1)
mySchwarz(x1,y1,dt);