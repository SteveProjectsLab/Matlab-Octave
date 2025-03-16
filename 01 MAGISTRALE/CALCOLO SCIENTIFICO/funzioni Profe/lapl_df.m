% definisco i parametri del dominio 
xa=0; xb=1; 
ya=0; yb=1;

f=@(x,y)[pi^2*(x.^2+y.^2).*sin(pi*x.*y)];
g=@(x,y)[sin(pi*x.*y)];
% f=@(x,y)[0*x+0*y];
% g=@(x,y)[y+x];

nx=25; ny=30;

Err=[];H=[];
for nx=[20,40,80,160]
    ny=nx
%%%%%%%%%%%%%%%%%%%%%%%%%%%
nx1=nx+1; ny1=ny+1;
N=nx1*ny1;
hx=(xb-xa)/nx; hy=(yb-ya)/ny;
H=[H;hx];

% costruisco la mesh
x=linspace(xa,xb,nx1);
y=linspace(ya,yb,ny1);
xy=zeros(N,2);
for j=1:ny1
    for i=1:nx1
        k=(j-1)*nx1+i;
        xy(k,:)=[x(i),y(j)];
    end
end

% costruisco la matrice del laplaciano
alpha=-1/hy^2; beta=-1/hx^2; gamma=2*(1/hx^2+1/hy^2);
e=ones(N,1);
A=spdiags([alpha*e,beta*e,gamma*e,beta*e,alpha*e],[-nx1,-1,0,1,nx1],N,N);



% sistemo le condizioni al bordo
lbordo=[(1:nx1)';(nx1:nx1:N)';(nx1+1:nx1:N)'; (nx1*ny+1:N)'];
lbordo=unique(lbordo);
lista=(1:N)';
linterni=setdiff(lista,lbordo);
for i=1:length(lbordo);
    k=lbordo(i);
    A(k,:)=0; A(k,k)=1;
end

% costruisco il termine noto
b=f(xy(:,1),xy(:,2));
for i=1:length(lbordo);
    k=lbordo(i);
    b(k)=g(xy(k,1),xy(k,2));
end

% risolvo il sistema lineare
u=A\b;

% disegno la soluzione

uu=reshape(u,nx1,ny1);
uu=uu';
mesh(x,y,uu)
xlabel('x');
ylabel('y');
%print(1,'-deps2c','sol1_poisson')

err=max(abs(u-g(xy(:,1),xy(:,2))))
Err=[Err;err];
end
figure(2)
loglog(H,Err,'b',H,H.^2,'r')
legend('errore','H^2');xlabel('h');
grid on
print(2,'-deps2c','err1_poisson')
