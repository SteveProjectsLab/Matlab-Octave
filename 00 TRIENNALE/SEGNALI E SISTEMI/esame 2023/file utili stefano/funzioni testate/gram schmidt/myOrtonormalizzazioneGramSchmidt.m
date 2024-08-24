function y = myOrtonormalizzazioneGramSchmidt( Base, dim ,x ,dt)
%APPROSSIMAZIONE GRAM-SCHMIDT: 
%   %Data una base NON ortonormale permette di
%   ortonormalizzarla tramite il processo di Gram-Schmidt
%   La funzione restituisce una base ortonormale.

Base_ort=zeros(dim, length(x));
for k=1:dim
    
    if(k==1)
        Base_ort(k,:)= Base(k,:)/myNorm(Base(k,:), dt);
    else
        sommatoria=zeros(1, length(x));
        for r=1:k-1
            
            sommatoria= sommatoria + myScalarProduct(Base(k,:),Base_ort(r,:) ,dt)*Base_ort(r,:);
            
        end
        
        v= Base(k,:)- sommatoria;
        Base_ort(k,:)= v/myNorm(v, dt);
    end
        
end
y= Base_ort;

end

