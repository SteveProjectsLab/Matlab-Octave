function y = myGramSchmidtApproximation( Base, dim ,x ,dt)
%APPROSSIMAZIONE GRAM-SCHMIDT: Data una base NON ortonormale permette di
%ortonormalizzarla tramite il processo di Gram-Schmidt
%La funzione restituisce una base ortonormale.
%   Detailed explanation goes here
Bort=zeros(dim, length(x));
for k=1:dim
    
    if(k==1)
        Bort(k,:)= Base(k,:)/myNorm(Base(k,:), dt);
    else
        sommatoria=zeros(1, length(x));
        for r=1:k-1
            
            sommatoria= sommatoria + myScalarProduct(Base(k,:),Bort(r,:) ,dt)*Bort(r,:);
            
        end
        
        v= Base(k,:)- sommatoria;
        Bort(k,:)= v/myNorm(v, dt);
    end
        
end
y= Bort;

end

