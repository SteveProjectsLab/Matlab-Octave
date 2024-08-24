%serve per verificare la funzione "puntomedio(x,dt)"

clear
close all
clc

dt=0.01;
t=-10:dt:10;



x=tri(t-4);
plot(t,x);
fprintf('approssimazione area tri:%.3f\n',puntomedio(x,dt))

% l'area risulta 1 ed è corretta

fprintf("\npremere un tasto per continuare\n")
pause; 
clc
close all