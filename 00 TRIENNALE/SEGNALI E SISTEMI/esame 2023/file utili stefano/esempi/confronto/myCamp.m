function [x_c] = myCamp(x,Tc,t)
%MYCAMP campiona il vettore x con Tc=k*dt (k intero > 0)
%   decimazione di un fattore k con zero interleaving
%  
dt=t(2)-t(1);
k=Tc/dt;
k=round(k);
x_c=zeros(size(x));

for h = 1:k:length(t)
    x_c(h)=x(h);
end

end

