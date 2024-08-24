% es fill-in

n=10;
A=zeros(n);
A(1,:)=1; % inizializzo tutta la prima riga
A(:,1)=1; % inizializzo tutta la prima colonna
for i=2:n
    A(i,i)=3;
end

figure(1); clf
subplot(2,2,1)
spy(A)
title('A')

[L,U,P]=fattlu(A,1);
subplot(2,2,2)
spy(L)
title('L')

subplot(2,2,3)
spy(U)
title('U')

subplot(2,2,4)
spy(P)
title('P')

As=sparse(A)

