function [zero, k, res]=bisezione(f,a,b,tol,kmax)
% metodo di bisezione per il caolo di radici di funzioni reali
% input: f: function handle della funzione
%        a,b : estremi dell'intervallo
%        tol : tolleranza per il test d'arresto
%        kmax: numero massimo di iterazioni 
% output: zero: approssimazione della radice
%         k : numero di iterazioni effettuate
%         res : residuo finale
%  [zero, k, res]=bisezione(f,a,b,tol,kmax)

if(f(a)*f(b)>0)
    warning('Attenzione non sono soddisfatte le ipotesi del metodo')
    k=0; zero=[]; res=[];
    return 
end
k=0; 
err=(b-a)/2;
c=(a+b)/2;
while err>=tol && k < kmax
    k=k+1;
    if f(a)*f(c)<0
        b=c;
        c=(a+b)/2;
        err=(b-a)/2;
    elseif f(b)*f(c)<0
        a=c;
        c=(a+b)/2;
        err=(b-a)/2;
    else
        err=0; k=k-1;
    end
end
zero=c;
res=f(zero);