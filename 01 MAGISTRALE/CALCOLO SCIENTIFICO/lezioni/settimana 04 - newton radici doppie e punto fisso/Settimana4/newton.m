function [z,res,it,ERR]=newton(f,df,x0,tol,kmax)
% Metodo di Newton per l'appx. di radici di eq. non lineari
% [z,res,it,ERR]=newton(f,df,x0,tol,kmax)
% Input: f = function handle della funzione f
%        df =  function handle della derivata prima di f
%        x0 = punto iniziale 
%        tol = tolleranza per il test d'arresto
%        kmax = numero massimo di iterazioni
% Output: z = approssimazione della radice
%         res = f(z) residuo dell'equazione
%         it = numero di iterazioni effettuate
%         ERR = vettore con gli errori ai vari passi

it=0; % contatore iterazioni
err=tol+1; % stimatore dell'errore
ERR=err;
while (it<=kmax && err>tol)
  xnew=x0-f(x0)/df(x0); % nuova iterata
  err=abs(xnew-x0); % stimatore
  ERR=[ERR;err];
  it=it+1; % aggiorno il contatore di iterazioni
  x0=xnew;
end
z=xnew;
res=f(z);
