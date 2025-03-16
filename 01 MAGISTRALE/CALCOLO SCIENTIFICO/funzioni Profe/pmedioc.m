function Imp=pmedioc(f,a,b,M)
%Formula composita del punto medio.
%   imp =pmedioc(fun,a,b,M) calcola una
%   approssimazione dell'integrale della funzione fun(x)
%   tramite la formula composita del punto medio
%   (su M intervalli di uguale ampiezza). 
H=(b-a)/M;
x = linspace(a,b,M+1);
Imp=0;
for k=2:M+1;
    Imp=Imp+f((x(k-1)+x(k))/2);
end
Imp=Imp*H;

return
