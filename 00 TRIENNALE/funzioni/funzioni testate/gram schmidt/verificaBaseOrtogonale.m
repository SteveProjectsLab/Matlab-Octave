function verifica = verificaBaseOrtogonale(Base, dim, t)
%VERIFICABASEORTOGONALE Summary of this function goes here
%   Costruisco una matrice G contenente i prodotti scalari dei vari
%   elementi della Base data e verifico che la matrice B sia la matrice I,
%   ovvero la matrice Identica

dt=t(2)-t(1);

G=zeros(dim, dim);

for k=1:dim
    for h=1:dim
        
        G(k,h)= myScalarProduct(Base(k,:), Base(h,:), dt);
        %assegno ad ogni elemento di G il valore del prodotto scalare tra
        %la prima funzione fissata B(k,:) e la seconda funzione B(h,:) che
        %itera grazie al 2° ciclo for
        
        %Verifico che G sia la matrice I
        if(k==h)
            if(abs(G(k,h)-1)> 10^-2)
                fprintf('La Base NON è ortogonale\n');
                return ;
            end
        else
            if(abs(G(k,h))> 10^-2)
                fprintf('La Base NON è ortogonale\n');
                return ;
            end
        end
    end
    
end


    fprintf('La Base è ortogonale\n');

end

