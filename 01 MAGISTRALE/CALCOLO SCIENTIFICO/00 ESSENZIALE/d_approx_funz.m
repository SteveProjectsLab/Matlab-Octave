f=@(x) (x+2)/7.*cos(x)   % funzione da approssimare

%% utilizzo nodi equispaziati
x1=linspace(a,b,200);
f1=f(x1); 
y1=polyval(a,x1);
err=max(abs(f1-y1));
%% utilizzo nodi di Cheb
xs=-cos(pi*(0:n)/n); xs=xs'; % nodi su [-1,1]
x=(xb-xa)/2*xs+(xa+xb)/2;  % nodi su [xa,xb]
y=f(x);

if n<20 %matrice VM ancora ok
        X=vander(x);
        a=X\y;
        y1=polyval(a,x1);
            
elseif n>=20    % la matrice di VM sarebbe mal condizionata
    y1=barycentric(x,y,x1);
end


%% rappresento l'andamento dell'errore

semilogy((1:n), ERR, '-*','Linewidth',2)