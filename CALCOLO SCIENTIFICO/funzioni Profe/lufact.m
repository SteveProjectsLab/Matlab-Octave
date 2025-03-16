function [L,U,P]=lufact(A,piv);
% [L,U,P]=lufact(A,piv);
% fattorizzazione LU di A con o senza pivoting per righe
% Input A= matrice quadrata non singolare
%       piv: =0 (non viene effettuata la pivotazione)
%            =1 (viene effettuata la pivotazione per righe)
% output L, U, P tali che  L*U=P* A
%        L=triangolare inferiore
%        U=triangolare superiore
%        P=matrice di permutazione

[n,m]=size(A);
if n==m 
    % inizializzo la matrice di permutazione = Identita`
    P=speye(n);
    for k=1:n-1
        % fase di pivotazione
        if piv==1
            % cerco il max dei valori assoluti nella colonna k di A
            % solo per le righe che vanno da k a n
            %x=massimo, non mi serve, mi e' utile rs
        [x,rs]=max(abs(A(k:n,k)));
        rs=rs+k-1;
        % scambio riga k con riga rs
        t=A(k,:);
        A(k,:)=A(rs,:);
        A(rs,:)=t;
        % stesso scambio sulla matrice P
         t=P(k,:);
        P(k,:)=P(rs,:);
        P(rs,:)=t;     
        end
        % fine lavoro di pivotazione
        for i=k+1:n
            A(i,k)=A(i,k)/A(k,k);
            for j=k+1:n
                A(i,j)=A(i,j)-A(i,k)*A(k,j);
            end
        end
    end
 U=triu(A);
 L=tril(A,-1)+speye(n);

else
    warning('La matrice non e` quadrata')
    L=[]; U=[];
    return
end
