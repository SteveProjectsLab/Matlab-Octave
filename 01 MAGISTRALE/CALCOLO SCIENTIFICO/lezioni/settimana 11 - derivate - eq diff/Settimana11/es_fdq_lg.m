% quadratura gaussiana
% dati
f=@(x)cos(x).*exp(-x.^2);
xa=-3; xb=2;
% calcolo nodi e pesi di quadratura Legendre-Gauss
[x,w]=xwlg(10,xa,xb);
% calcolo l'integrale con la sommatoria
Ilg= sum(f(x).*w)
