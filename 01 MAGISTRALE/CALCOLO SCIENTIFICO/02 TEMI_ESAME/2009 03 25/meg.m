function x=meg(A,b)
%  x=meg(A,b)
% meg: risoluzione di un sist. quadrato con MEG senza pivotazione
% Input: A= matrice quadrata non singolare
%        b= termine noto
%
% Output: x= soluzione del sistema Ax=b
%
[n,m]=size(A);
p=length(b);
if n~= m
    disp('matrice non quadrata')
    return
end
if p~=m 
    disp('termine noto non compatibile con la matrice')
    return
end

% algoritmo

for k=1:n
    if A(k,k)==0 
        disp('Attenzione, minore singolare, svolgere la pivotazione')
	x = [] ;
	return
    end
    for i=k+1:n
    mik=A(i,k)/A(k,k);
    for j=k+1:n
        A(i,j)=A(i,j)-mik*A(k,j);
     end
       b(i)=b(i)-mik*b(k);
    end
end

x=backsub(A,b);
