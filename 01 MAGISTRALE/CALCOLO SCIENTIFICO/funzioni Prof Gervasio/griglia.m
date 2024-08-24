function [A,b1,b2]=griglia(n1,n2)

n=n1*n2;
hx=1/(n1-1);hy=1/(n2-1);
hx2=1/(hx*hx);hy2=1/(hy*hy);
alpha=2*(hx2+hy2); beta=-hx2; gamma=-hy2;

% costruzione di A

e=ones(n,1);
A=spdiags([gamma*e beta*e alpha*e beta*e, gamma*e], [-n1,-1,0,1,n1], n,n);
 
lati=cell(4,1);
lati{1}=1:n1;
lati{2}=n1:n1:n;
lati{3}=n1*(n2-1)+1:n;
lati{4}=1:n1:n;
bordo=[lati{1},lati{2},lati{3},lati{4}]';
bordo=unique(bordo);
A(bordo,:)=0;
for i=1:length(bordo)
  A(bordo(i),bordo(i))=1;
end

%
% costruisco il termine noto per x
%

gx=cell(4,1); gy=cell(4,1);
gx{1}=@(t)cos(t); gy{1}=@(t)sin(t);
gx{2}=@(t)cos(t)+1; gy{2}=@(t)sin(t)+1;
gx{3}=@(t)cos(t); gy{3}=@(t)sin(t);
gx{4}=@(t)cos(t)-1; gy{4}=@(t)sin(t)-1;

b1=zeros(n,1); b2=b1;
% lato 1
t=linspace(pi*3/2,2*pi,n1);
b1(lati{1})=gx{1}(t);
b2(lati{1})=gy{1}(t);
% lato 2
t=linspace(pi,3*pi/2,n2); t=sort(t,'descend');
b1(lati{2})=gx{2}(t);
b2(lati{2})=gy{2}(t);
% lato 3
t=linspace(pi,pi/2,n1); t=sort(t,'descend');
b1(lati{3})=gx{3}(t);
b2(lati{3})=gy{3}(t);
% lato 4
t=linspace(0,pi/2,n2);
b1(lati{4})=gx{4}(t);
b2(lati{4})=gy{4}(t);
