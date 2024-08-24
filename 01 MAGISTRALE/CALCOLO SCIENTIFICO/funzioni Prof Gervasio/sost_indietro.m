function [x]=sost_indietro(U,b);
% [x]=sost_indietro(U,b);
% risoluzione di un sist triangolare superiore
% input: U=matrice triangolare superiore (formato full o sparse), 
%        b=vettore termine noto (colonna)
%  output: x=vettore soluzione 
[n,m]=size(U);
if n==m 
    [p,q]=size(b);
    if p==m && q==1
        x=zeros(n,1);
     % risolvere il sistema
     for i=n:-1:1
         x(i)=(b(i)-    U(i,i+1:n)*x(i+1:n)     )/U(i,i);
     end
     
    else
        warning('il termine noto non e` compatibile con il sistema')
        x=[];
        return
    end
    
else
    warning('la matrice non e` quadrata')
    x=[];
    return
end
