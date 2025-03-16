function [A,b]=sislin(n)
%  SISLIN
%   [A,b]=sislin(n)
%
%
% Input: n =  intero >=3. La dimensione della matrice sara' pari a
%             ndim=n^2-4*(n-1)
% Output: A = matrice quadrata di dimensione =ndim
%         b = vettore colonna di lunghezza =ndim
%


xa=-1;xb=1;   % Omega=(xa,xb) x (ya,yb)
ya=-1;yb=1;
nx=1;ny=1;
nex=n-1; ney=nex;
npdx=nx+1; npdy=ny+1; ldnov=npdx*npdy; mn=ldnov; ne=nex*ney;

uex=@(x,y)[sin(pi*x).*cos(pi*y)];
ff=@(x,y)[2*pi^2*sin(pi*x).*cos(pi*y)];

[nov]=cosnov_2d(npdx,nex,npdy,ney);
noe=nov(ldnov,ne); cb='dddd';
x=[-1;1];y=x;wx=[1;1];wy=wx;
[xx,yy,jacx,jacy,xy,ww,ifro]=mesh2d(xa,xb,ya,yb,cb,nex,ney,npdx,npdy,...
nov,x,wx,y,wy,[],[]);
A=sparse(noe,noe);
Al=[1 -0.5 -0.5 0; -0.5  1 0 -0.5; -0.5  0 1 -0.5; 0 -0.5 -0.5 1];
for ie=1:ne
A(nov(1:ldnov,ie),nov(1:ldnov,ie))=A(nov(1:ldnov,ie),nov(1:ldnov,ie))+Al;
end

b=ff(xy(:,1),xy(:,2)).*ww;
[ldir,lint,lintint,lgamma,ifro]=liste(ifro,nov);


% Setting Dirichlet boundary conditions on both matrix and r.h.s
ub=zeros(noe,1);
for i=1:noe
if(ifro(i)==1)
ub(i)=uex(xy(i,1),xy(i,2));
end
end

if length(ldir)>0
b(lint)=b(lint)-A(lint,ldir)*ub(ldir);
A=A(lint,lint); 
b=b(lint);
end

return

function [nov]=cosnov_2d(npdx,nex,npdy,ney);
ldnov=npdx*npdy;
ne=nex*ney;
nov=zeros(ldnov,ne);

% element 1

nov(:,1)=(1:ldnov)';

% elements first column

k=ldnov-npdx;
for ie=2:ney
nov(:,ie)=(k+1:k+ldnov)';
k=k+ldnov-npdx;
end
kmax=k+npdx;

% other columns

nxm1=npdx-1;
for iex=2:nex

%  other rows, bottom elements

ie=(iex-1)*ney+1;
for j=1:npdy
k=(j-1)*npdx;
nov(k+1,ie)=nov(j*npdx,ie-ney);
nov(k+2:k+npdx,ie)=(kmax+1:kmax+nxm1)';
kmax=kmax+nxm1;
end

% other elements

for iey=2:ney
ie=(iex-1)*ney+iey;

% first row
nov(1:npdx,ie)=nov(ldnov-npdx+1:ldnov,ie-1);
for j=2:npdy
k=(j-1)*npdx;
nov(k+1,ie)=nov(j*npdx,ie-ney);
nov(k+2:k+npdx,ie)=(kmax+1:kmax+nxm1)';
kmax=kmax+nxm1;
end

end
end

function[xx,yy,jacx,jacy,xy,ww,ifro]=mesh2d(xa,xb,ya,yb,cb,nex,ney,npdx,npdy,...
nov,x,wx,y,wy,gammax,gammay)

ldnov=npdx*npdy; ne=nex*ney;
noe=nov(ldnov,ne); nx=npdx-1;
xx=zeros(4,ne); yy=zeros(4,ne); 
xy=zeros(noe,2); ww=zeros(noe,1);
jac=zeros(ne,1);
jacx=zeros(ne,1);
jacy=zeros(ne,1);
if sum(size(gammax))==0 
    Hx=(xb-xa)/nex*ones(nex);
else 
    Hx=zeros(nex,1);
    Hx(1)=gammax(1)-xa;
    Hx(2:nex-1)=gammax(2:nex-1)-gammax(1:nex-2);
    Hx(nex)=xb-gammax(nex-1);
end
if sum(size(gammay))==0 
    Hy=(yb-ya)/ney*ones(ney);
else 
    Hy=zeros(ney,1);
    Hy(1)=gammay(1)-ya;
    Hy(2:ney-1)=gammay(2:ney-1)-gammay(1:ney-2);
    Hy(ney)=yb-gammay(ney-1);
end

for iex=1:nex
ie1=(iex-1)*ney+1;
xx(1,ie1)=xa+sum(Hx(1:iex-1));
xx(2,ie1)=xx(1,ie1)+Hx(iex);
xx(3,ie1)=xx(2,ie1); xx(4,ie1)=xx(1,ie1);
jacx(ie1)=Hx(iex)*.5;
for iey=2:ney
ie=ie1-1+iey; xx(:,ie)=xx(:,ie1);
jacx(ie)=Hx(iex)*.5;
end
end


for iey=1:ney
yy(1,iey)=ya+sum(Hy(1:iey-1));
yy(2,iey)=yy(1,iey);
yy(3,iey)=yy(1,iey)+Hy(iey); yy(4,iey)=yy(3,iey);
jacy(iey)=Hy(iey)*.5;
for iex=2:nex
ie=(iex-1)*ney+iey; yy(:,ie)=yy(:,iey);
jacy(ie)=Hy(iey)*.5;
end
end


for ie=1:ne
bpa=(xx(1,ie)+xx(2,ie))*.5; bpc=(yy(1,ie)+yy(3,ie))*.5; 

for j=1:npdy
for i=1:npdx
k=(j-1)*npdx+i; ii=nov(k,ie);
xy(ii,1)=x(i)*jacx(ie)+bpa; xy(ii,2)=y(j)*jacy(ie)+bpc;
ww(ii)=ww(ii)+wx(i)*jacx(ie)*wy(j)*jacy(ie); 
end
end

end


ifro=zeros(noe,1);

% Loop on elements
for ie=1:ne

% side 1
for i=1:npdx
k=i; ii=nov(k,ie); 
if(abs(xy(ii,2)-ya)<=1.e-12 ) 
if cb(1)=='d'
ifro(ii)=1;
elseif cb(1)=='n'
ifro(ii)=31;
end
end
end

% side 2
for j=1:npdy
k=j*npdx; ii=nov(k,ie); 
if(abs(xy(ii,1)-xb)<=1.e-12 ) 
if cb(2)=='d'
ifro(ii)=1;
elseif cb(2)=='n'
ifro(ii)=31;
end
end
end

% side 3
nm=npdx*(npdy-1);
for i=1:npdx
k=i+nm; ii=nov(k,ie); 
if(abs(xy(ii,2)-yb)<=1.e-12 ) 
if cb(3)=='d'
ifro(ii)=1;
elseif cb(3)=='n'
ifro(ii)=31;
end
end
end

% side 4
for j=1:npdy
k=(j-1)*npdx+1; ii=nov(k,ie);
if(abs(xy(ii,1)-xa)<=1.e-12 )
if cb(4)=='d'
ifro(ii)=1;
elseif cb(4)=='n'
ifro(ii)=31;
end
end
end
% check vertices: if vertex V belongs to two sides with different (N/D)
%boundary conditions, dirichlet b.c. prevails.

% V1
ip=nov(1,ie);
if ifro(ip)>0 & cb(1)~=cb(4)
ifro(ip)=1;
end
% V2
ip=nov(npdx,ie);
if ifro(ip)>0 & cb(1)~=cb(2)
ifro(ip)=1;
end
% V3
ip=nov(ldnov,ie);
if ifro(ip)>0& cb(2)~=cb(3)
ifro(ip)=1;
end
% V4
ip=nov(ldnov-nx,ie);
if ifro(ip)>0& cb(4)~=cb(3)
ifro(ip)=1;
end


% end loop for ie=1:ne
end
function [lbor,lint,lintint,lgamma,ifro]=liste(ifro,nov);

[ldnov,ne]=size(nov);
noe=nov(ldnov,ne);
v=zeros(noe,1);
for ie=1:ne
for i=1:ldnov
ip=nov(i,ie);
v(ip)=v(ip)+1;
end
end


lint=[];lbor=[];lgamma=[]; lintint=[];
for i=1:noe
if(ifro(i)==1)
lbor=[lbor;i];
else
lint=[lint;i];
end
if(v(i)>1 & ifro(i)==0)
ifro(i)=-1;
end
end

for i=1:length(lint)
if(ifro(lint(i))==-1)
lgamma=[lgamma;i];
else
lintint=[lintint;i];
end
end

return
