X=zeros(m+1); b=zeros(m+1,1);
for i=1:m+1
for j=1:m+1
    X(i,j)=sum(x.^(m+1-i+m+1-j));
end
b(i)=sum(x.^(m+1-i).*y);
end