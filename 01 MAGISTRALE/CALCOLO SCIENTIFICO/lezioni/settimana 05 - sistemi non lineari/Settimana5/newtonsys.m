function [zero,res,k,ERR]=newtonsys(f,Jf,x0,tol,kmax)
% Metodo di Newton per sistemi di eq. non lineari
%  [zero,res,k,ERR]=newtonsys(f,Jf,x0,tol,kmax)
k=0; % iterazione
err=tol+1;
ERR =err; % vettore degli errori
while err> tol && k <=kmax
    b=-f(x0);
    A=Jf(x0);
    z=A\b; % implementa MEG
    xnew=x0+z; % nuova soluzione
    err=norm(z); % z=xnew-x0
    ERR=[ERR;err]; % aggiorno il vettore degli errori
    k=k+1;
    x0=xnew;
end
zero=xnew;
res=f(zero);