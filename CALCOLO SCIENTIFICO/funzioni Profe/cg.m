function [x,res,k,resv]=cg(A,b,x0,tol,kmax,varargin)
% CG metodo del gradiente coniugato per risolvere Ax=b, A simm. def. pos.
%  [X,REL,K,RESV]=CG(A,B,X0,TOL,KMAX)
%  [X,REL,K,RESV]=CG(A,B,X0,TOL,KMAX,RP)
%  risolve il sistema A*X=B con il metodo del gradiente
%  coniugato.
%  X0 e` il vettore iniziale.
%  TOL specifica la tolleranza per il test d'arresto. 
%  KMAX indica il numero massimo di iterazioni ammesse.
%  Il parametro opzionale RP contiene una matrice 
%  triangolare superiore tale per cui
%  il precondizionatore e` definito come P = RP'*RP.
%  RES e` la norma del residuo corrispondende alla
%  soluzione calcolata diviso la norma del vettore B.
%  K e` il numero di iterazioni effettuate dal metodo,
%  RESV e` un vettore contenente la norma dei residui
%  (diviso la norma di b) ad ogni passo del metodo

k = 0;
bnorm = norm(b);
if nargin==5
  RP=[];
else
  RP=varargin{1};
end
if bnorm==0
x=zeros(n,1); res=0;
else
r=b-A*x0;   x=x0;
% sistema sul precondizionatore
if ~isempty(RP); z=RP'\ (RP\r); else,  z=r; end
zr=z'*r;  
res=zr/bnorm; d=z;
resv=res;
while k< kmax && res > tol 
    v=A*d; vd=v'*d;
    alpha=zr/vd;
    x=x+alpha*d;
    r=r-alpha*v;
    if ~isempty(RP); z=RP'\ (RP\r); else  z=r; end
    beta=(v'*z)/vd;
    d=z-beta*d;
    zr=z'*r;
    res=sqrt(zr)/bnorm;
    resv=[resv; res];
    k=k+1;
end
end
