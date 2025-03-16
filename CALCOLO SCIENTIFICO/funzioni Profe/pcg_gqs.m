function [x,k,res,resvec]=pcg_gqs(A,b,x,kmax,tol,R);
% [x,k,res,resvec]=pcg_gqs(A,b,x,kmax,tol,R);
% Algoritmo GQS, pag. 168
%  A, P spd
% P e fornita fattorizzata, R'*R=P
if nargin==5
    preco=0;
else
    preco=1;
end
res=tol+1; k=0;
resvec=[];

r=b-A*x;
if preco==1
    z=R\(R'\r);
else
    z=r;
end
p=z;
while res> tol & k < kmax
    v=A*p;
    alphak=(p'*r)/(p'*v);
    x=x+alphak*p;
    r=r-alphak*v;
    if preco==1
       z=R\(R'\r);
    else
       z=r;
    end
    betak=(v'*z)/(v'*p);
    p=z-betak*p;
    res=norm(r)/norm(b);
    resvec=[resvec;res];
    k=k+1;
end
