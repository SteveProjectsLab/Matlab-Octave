function [z,res,it]=secanti(f,x0,x1,tol,kmax)
% Metodo di secanti per l'appx. di radici di eq. non lineari
% [z,res,it]=secanti(f,x0,x1,tol,kmax)
% Input: f = function handle della funzione f
%        x0,x1 = punti iniziali 
%        tol = tolleranza per il test d'arresto
%        kmax = numero massimo di iterazioni
% Output: z = approssimazione della radice
%         res = f(z) residuo dell'equazione
%         it = numero di iterazioni effettuate
 
it=0; % contatore iterazioni
err=tol+1; % stimatore dell'errore
while (it<=kmax && err>tol)
  msegnato=(f(x1)-f(x0))/(x1-x0); % coeff. angolare della retta secante
  xnew=x1-f(x1)/msegnato; % nuova iterata
  err=abs(xnew-x1); % stimatore dell'errore
  it=it+1;
  x0=x1;
  x1=xnew;
end
z=xnew;
res=f(z);
