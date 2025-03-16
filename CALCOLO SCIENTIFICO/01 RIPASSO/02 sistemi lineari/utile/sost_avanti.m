function [x]=sost_avanti(L,b);
% [x]=sost_avanti(L,b);
% risoluzione di un sist triangolare inferiore
% input: L=matrice triangolare inferiore (in formato full o sparse), 
%        b=vettore termine noto (colonna)
%  output: x=vettore soluzione
[n,m]=size(L);
if n==m 
    [p,q]=size(b);
    if p==m && q==1
        x=zeros(n,1);
     % risolvere il sistema
     for i=1:n
         x(i)=(b(i)-    L(i,1:i-1)*x(1:i-1)     )/L(i,i);
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
