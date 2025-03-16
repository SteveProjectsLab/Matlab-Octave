function [int]=fdq(f,a,b,M)
% int=fdq(f,a,b,M)
% Una formula di quadratura
xx=linspace(a,b,M+1);
int=0;
for k=1:M
    a=xx(k); b=xx(k+1);
x=[a,(2*a+b)/3,(2*b+a)/3,b];
w=(b-a)/8*[1,3,3,1]';
int_M=f(x)*w;
int=int+int_M;
end
