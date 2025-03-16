function Int=quad_gl(fun,a,b,np)
% QUAD_GL Calcolo di integrale con formula gaussiana
% int=quad_gl(fun,a,b,np) calcola l'integrale della
% funzione y=fun(x) sull'intervallo [a,b] con una
% formula di tipo gaussiano, utilizzando np punti
% non equispaziati
% Input: 
%    a = estremo sinistro dell'intervallo
%    b = estremo destro dell'intervallo
%    np = numero di punti utilizzati nella fdq
%    fun = funzione definita con function handle 
%              e OPERAZIONI PUNTO  !!!!!!!!!!!!!!
% Output: Int = valore calcolato


[x,w]=xwlg(np,a,b);
Int=(fun(x))'*w;
return


function [x,w] = xwlg(np,a,b)
%XWLG  Computes nodes and weights of the Legendre-Gauss  quadrature formula.
%
%    [x,w]=xwlg(np) returns the np weigths and nodes 
%    of the corresponding Legendre Gauss quadrature 
%    formula in the reference interval (-1,1).
%
%    [x,w]=xwlg(np,a,b) returns the np weigths and the nodes 
%    of the corresponding Legendre Gauss quadrature 
%    formula in the  interval (a,b).
%
% Input: np = number of nodes
%        a, b = extrema of the interval
%
% Output: x(np,1) = LG nodes  (CHQZ2, (2.3.10), pag. 76)
%         w(np,1) = LG weigths (CHQZ2, (2.3.10), pag. 76)
%
%
% Reference: CHQZ2 = C. Canuto, M.Y. Hussaini, A. Quarteroni, T.A. Zang,
%                    "Spectral Methods. Fundamentals in Single Domains"
%                    Springer Verlag, Berlin Heidelberg New York, 2006.

%   Written by Paola Gervasio
%   $Date: 2007/04/01$


n=np-1;
if np<=1
  x=0;w=2;
  return
end
x=jacobi_roots(np,0,0);
w=2./(pnleg1(x,np).^2.*(1-x.^2));



%
% map on (a,b)
%
if nargin == 3
  bma=(b-a)*.5;
  bpa=(b+a)*.5;
  x=bma*x+bpa;
  w=w*bma;
end
return

function [x,flag] = jacobi_roots(n,alpha,beta) 
% JACOBI_ROOTS: Computes the n zeros of the Jacoby polynomial P_n^{(\alpha,\beta)}(x)
%   by Newton method and deflation process.
%
%    [x] = jacobi_roots(n,alpha,beta) 
%
% Input: n = polynomial degree
%        alpha,beta = parameters of Jacobi polynomial
%
% Output: x = zeros of Jacobi polynomial (column array of size n)
%         flag  = -1: The polynomial degree should be greater than 0
%
% Reference: CHQZ2 = C. Canuto, M.Y. Hussaini, A. Quarteroni, T.A. Zang,
%                    "Spectral Methods. Fundamentals in Single Domains"
%                    Springer Verlag, Berlin Heidelberg New York, 2006.

%   Written by Paola Gervasio
%   $Date: 2007/04/01$


flag=0;
if n < 1 
  es='The polynomial degree should be greater than 0';
  disp(es); flag = -1; x = []; 
return 
 
else
x=zeros(n,1);

x0=cos(pi/(2*n));
tol=1.e-14; kmax=15;
for j=1:n
 diff=tol+1;kiter=0;
    while kiter <=kmax & diff>=tol
        [p,pd]=jacobi_eval(x0,n,alpha,beta);
% deflation process q(x)=p(x)/((x-x_1)*... (x-x_{j-1}))
% q(x)/q'(x)=p(x)/[p'(x)-p(x)*\sum_{i<j} 1/(x-x_i)]
        ss=sum(1./(x0-x(1:j-1)));
        x1=x0-p/(pd-ss*p);
        diff=abs(x1-x0);
        kiter=kiter+1;
        x0=x1;
    end
    x0=5.d-1*(x1+cos((2*(j+1)-1)*pi/(2*n)));
    x(j)=x1;
end 
x=sort(x);
end


return

function [p1,p] = pnleg1 (x, n) 
% PNLEG1    Evaluates the first derivative of Legendre polynomial
%           of degree n 
%
%    [p1,p]=pnleg1(x,n)  evaluates (L_n)'(x), L_n(x)
%    at the node(s) x, using the three term relation  (2.3.3), pag. 75 CHQZ2.
%
% Input: x = scalar or column array
%        n = degree of Legendre polynomial
%
% Output: p1 = scalar or column array (same dimension as x)
%             with the evaluation of (L_n)'(x)
%         p  = scalar or column array (same dimension as x)
%             with the evaluation of L_n(x)
%
% Reference: CHQZ2 = C. Canuto, M.Y. Hussaini, A. Quarteroni, T.A. Zang,
%                    "Spectral Methods. Fundamentals in Single Domains"
%                    Springer Verlag, Berlin Heidelberg New York, 2006.

%   Written by Paola Gervasio
%   $Date: 2007/04/01$


nn=size(x);

if nn==1
    % x is a scalar
    p=0; p1=0;
if n==0
p=1;p1=0;
elseif n==1
p=x;p1=1;
else
p1=0;p2=0;p11=0;p21=0;p3=0;p31=0;
p1=1;  p2=x; 
p11=0; p21=1;
for k =1:n-1
   duekp1=2*k+1;kp1=1/(k+1);
   p3=(duekp1*x*p2-k*p1)*kp1; 
   p31=(duekp1*(x*p21+p2)-k*p11)*kp1; 
   p11=p21; p21=p31; 
   p1=p2; p2=p3; 
end 
p1=p31; p=p3;
end

else
x=x(:);
    % x is an array
p=zeros(nn); p1=p;
if n==0
p=ones(nn);p1=zeros(nn);
elseif n==1
p=x;p1=ones(nn);
else
p1=p;p2=p;p11=p;p21=p;p3=p;p31=p;
p1=1;  p2=x; 
p11=0; p21=1;
for k =1:n-1
   duekp1=2*k+1;kp1=1/(k+1);
   p3=(duekp1*x.*p2-k*p1)*kp1; 
   p31=(duekp1*(x.*p21+p2)-k*p11)*kp1; 
   p11=p21; p21=p31; 
   p1=p2; p2=p3; 
end 
p1=p31; p=p3;
end
end
return 


function [p,pd] = jacobi_eval(x,n,alpha,beta) 
% JACOBI_EVAL: Evaluates Jacobi polynomial P_n^{(\alpha,\beta)} at x\in(-1,1)
%
%              (formula (2.5.3) pag. 92, CHQZ2)
%  [p,pd] = jacobi_eval(x,n,alpha,beta) 
%
% Input: x = scalar or one-dimensional array of length (m) 
%        n =  polynomial degree
%        alpha, beta= parameters of Jacoby polynomial
%
% Output: p(m,3) = [P_n^{(\alpha,\beta)}(x),
%                   P_(n-1)^{(\alpha,\beta)}(x),
%                   P_(n-2)^{(\alpha,\beta)}(x)];
%
%         pd(m,3) = [(P_n^{(\alpha,\beta)})'(x),
%                    (P_(n-1)^{(\alpha,\beta)})'(x),
%                    (P_(n-2)^{(\alpha,\beta)})'(x)];
%
% Reference: CHQZ2 = C. Canuto, M.Y. Hussaini, A. Quarteroni, T.A. Zang,
%                    "Spectral Methods. Fundamentals in Single Domains"
%                    Springer Verlag, Berlin Heidelberg New York, 2006.

%   Written by Paola Gervasio
%   $Date: 2007/04/01$

apb=alpha+beta; ab2=alpha^2-beta^2; 

nn=length(x);
if nn==1
% x is a scalar
p=1;   pd=0; 
p1=0;  pd1=0;
p2=0;  pd2=0;
if n == 0    
   return 
elseif n==1
p1 = p; p2=p1;
p = (alpha-beta+(apb+2)*x)*0.5; 

pd1 = pd; pd2=pd1;
pd = 0.5*(apb+2); 
else
p1 = p; p2=p1;
p = (alpha-beta+(apb+2)*x)*0.5; 

pd1 = pd; pd2=pd1;
pd = 0.5*(apb+2); 
for k = 1:n-1 
   k1=k+1; k2=k*2; k2ab=k2+alpha+beta;
   k2ab1=k2ab+1; k2ab2=k2ab1+1;
   p2=p1; p1=p; 
   pd2=pd1; pd1=pd; 
   a1 = 2*k1*(k1+apb)*k2ab; 
% Gamma(x+n)/Gamma(x) = (x+n-1) * ... * (x+1) * x 
   a21 = k2ab1*ab2;
   a22 = k2ab2*k2ab1*k2ab; 
   a3=2*(k+alpha)*(k+beta)*k2ab2;
   p = ((a21+a22*x)*p1-a3*p2)/a1; 
   pd= (a22*p1+(a21+a22*x)*pd1-a3*pd2)/a1; 
end 
end

else
% x is an array

[m1,m2]=size(x);
if m1<m2
    x=x';
end
m=max(m1,m2);
p=[ones(m,1),zeros(m,1),zeros(m,1)];   pd=zeros(m,3); 
if n == 0    
   return 
elseif n==1
p(:,2) = p(:,1); p(:,3)=p(:,2);
p(:,1) = (alpha-beta+(apb+2)*x)*0.5; 

pd(:,2) = pd(:,1); pd(:,3)=pd(:,2);
pd(:,1) = 0.5*(apb+2); 
else
p(:,2) = p(:,1); p(:,3)=p(:,2);
p(:,1) = (alpha-beta+(apb+2)*x)*0.5; 

pd(:,2) = pd(:,1); pd(:,3)=pd(:,2);
pd(:,1) = 0.5*(apb+2);     
for k = 1:n-1 
    k2=k*2; k2ab=k2+alpha+beta;
   p(:,3)=p(:,2); p(:,2)=p(:,1); 
   pd(:,3)=pd(:,2); pd(:,2)=pd(:,1); 
   a1 = 2*(k+1)*(k+apb+1)*k2ab; 
% Gamma(x+n)/Gamma(x) = (x+n-1) * ... * (x+1) * x 
   a21 = (k2ab+1)*ab2;
   a22 = (k2ab+2)*(k2ab+1)*k2ab; 
   a3=2*(k+alpha)*(k+beta)*(k2ab+2);
   p(:,1) = ((a21+a22*x).*p(:,2)-a3*p(:,3))/a1; 
   pd(:,1)= (a22*p(:,2)+(a21+a22*x).*pd(:,2)-a3*pd(:,3))/a1; 
end 
end

end
return 
 
 
