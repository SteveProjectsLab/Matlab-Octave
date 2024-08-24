function [tn,un]=eulero_imp_sys(odefun,tspan,y0,Nh,varargin)

if nargin==4
    tol=1e-8;
    kmax=50
elseif nargin==5
    tol=varargin(1);
    kmax=50;
elseif nargin==6
    tol=varargin(1);
    kmax=varargin(2)
end

y0=y0(:);

d=length(y0);
t0=tspan(1);
T=tspan(2);
tn=linspace(t0,T,Nh+1)';
un=zeros(Nh+1,d);
un(1,:)=y0;
h=(tspan(2)-tspan(1))/Nh ;
B0=eye(d);

for n=1:Nh
     wn=un(n,:).';
     r=@(x)x-wn-h*odefun(tn(n+1),x);
     w=broyden(r,B0,wn,tol,kmax);
     un(n+1,:)=w.';
end