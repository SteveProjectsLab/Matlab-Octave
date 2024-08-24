function [z,res,it]=newton(f,df,x0,tol,kmax)
% Metodo di Newton per l'appx. di radici di eq. non lineari
% [z,res,it]=newton(f,df,x0,tol,kmax)
% Input: ....
% Output: ....

it=0; % contatore iterazioni
err=tol+1; % stimatore dell'errore
while (it<=kmax && err>tol)
  xnew=x0-f(x0)/df(x0); % nuova iterata
  err=abs(xnew-x0); % stimatore
  it=it+1; % aggiorno il contatore di iterazioni
  x0=xnew;
end
z=xnew;
res=f(z);
