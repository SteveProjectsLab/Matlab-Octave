function [alpha,niter,errori]=puntofisso(phi,x0,tol,kmax)
% metodo di punto fisso per ricerca di punti fissi
% [alpha,niter,errori]=puntofisso(phi,x0,tol,kmax)
% Input: phi = function handle della funzione di punto fisso
%        x0 = punto iniziale
%        tol= tolleranza per il test d'arresto
%        kmax =numero massimo di iterazioni
% Output: alpha = approssimazione del punto fisso
%         niter = numero di iterazioni svolte
%         errori = vettore degli errori ai vari passi

k=0; % contatore iterazioni
err=tol+1; 
errori = err; % vettore che conterra' tutti gli errori
while (err>tol && k<=kmax)
    xnew=phi(x0); % nuova x
    err=abs(xnew-x0); 
    errori=[errori; err];
    k=k+1;
    x0=xnew;
end
alpha=xnew;
niter=k;
