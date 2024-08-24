function [x,relres,k,res]=pgradiente(A,b,x0,tol,kmax,varargin)
% PGRADIENTE metodo del gradiente (precondizionato).
%  [X,RELRES,K,RES]=PGRADIENTE(A,B,X0,TOL,KMAX)
%  risolve il sistema A*X=B con il metodo del gradiente
%  (precondizionato). X0 e` il vettore iniziale,
%  TOL specifica la tolleranza per il test d'arresto.
%  KMAX indica il numero massimo di iterazioni ammesse.
%  [X,RELRES,K,RES]=PGRADIENTE(A,B,X0,TOL,KMAX,RP)
%  Il parametro opzionale RP contiene una matrice 
%  triangolare superiore t.c.
%  il precondizionatore e` definito come P = RP'*RP.
%  RELRES e` la norma del residuo corrispondende alla
%  soluzione calcolata diviso la norma del vettore B.
%  K e` il numero di iterazioni effettuate dal metodo,
%  RES e` un vettore contenente la norma dei residui
%  (diviso la norma di b)  ad ogni passo del metodo

k = 0;
bnorm = norm(b);
res=[ ];
if nargin==5
  RP=[];
else
  RP=varargin{1};
end
if bnorm==0
x=zeros(n,1); relres=0;
else
r=b-A*x0; x=x0;
% sistema sul precondizionatore
if ~isempty(RP); z=RP' \ (RP\r); else,  z=r; end
zr=z'*r;  relres=zr/bnorm;
while relres > tol && k< kmax
    v=A*z;
    alpha=zr/(z'*v);
    x=x+alpha*z;
    r=r-alpha*v;
    if ~isempty(RP); z=RP' \ (RP\r); else  z=r; end
    zr=z'*r;
    relres=sqrt(zr)/bnorm;
    res=[res; relres];
    k=k+1;
end
end
