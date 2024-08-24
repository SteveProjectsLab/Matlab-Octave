function [zero,res,k]=bisezione(f,a,b,tol,kmax)
% metodo di bsiezione per il calcolo di radici di eq. nonlineari
% [zero,res,k]=bisezione(f,a,b,tol,kmax)
% Input: .....
% Ouput: .....

% controllo che f(a)*f(b)<0
if f(a)*f(b)<0
  k=0; % contatore delle iterazioni
  c=(a+b)/2; % punto medio dell'intervallino generico
  err=(b-a)/2; % stimatore dell'errore
  while (k<=kmax && err> tol)
    k=k+1;
    if f(a)*f(c) < 0
      % seleziono il seminintervallo di sinistra
      b=c;
      c=(a+b)/2;
      err=(b-a)/2;
    elseif f(c)*f(b)<0
      % seleziono il semiintervallo di destra
      a=c;
      c=(a+b)/2;
      err=(b-a)/2;
    else
      % vuol dire f(c)==0
      err=0; k=k-1;
    end
  end
  zero=c;
  res=f(zero);

else
  disp('Attenzione f(a)*f(b)>=0, il metodo non e` detto che funzioni' )
  zero=[];
  res=[];
  k=[];
end





