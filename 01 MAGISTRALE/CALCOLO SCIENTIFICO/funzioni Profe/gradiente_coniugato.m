function [x,res,k,resvec]=gradiente_coniugato(A,b,x0,tol,kmax)
% metodo del gradiente coniugato per risolvere Ax=b
% [x,res,k,resvec]=gradiente_coniugato(A,b,x0,tol,kmax)
% Input: A = matrice quadrata sdp
%        b = vettore colonna termine noto
%        x0 = vettore colonna iniziale
%        tol= tolleranza per il test d'arresto
%        kmax= numero massimo di iterazioni
% Output: x = soluzione calcolata
%         res = ||r^(k)||/||b|| all'ultima iterazione
%         k =  numero di iterazioni svolte
%         resvec = vettore dei valori ||r^(k)||/||b|| per ogni iterazione


x=x0; % vettore generico per la soluzione
r=b-A*x; % residuo
d=r; % direzione di discesa
k=0; % contatore delle iterazioni
res=norm(r)/norm(b); % errore
resvec=[res];
while k<=kmax && res>tol
    v=A*d; % vettore ausiliario
    alpha=(d'*r)/(d'*v); % passo
    x=x+alpha*d; % aggiorno la soluzione
    r=r-alpha*v; % aggiorno il residuo
    beta=(v'*r)/(d'*v);
    d=r-beta*d; % aggiorno la direzione di discesa
    res=norm(r)/norm(b);
    resvec=[resvec;res]; % vettore dei residui
    k=k+1;
end
